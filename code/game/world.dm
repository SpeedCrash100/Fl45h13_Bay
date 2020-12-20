GLOBAL_VAR_INIT(server_name, "Baystation 12")

GLOBAL_VAR_INIT(game_id, null)
/hook/global_init/proc/generate_gameid()
	if(GLOB.game_id != null)
		return
	GLOB.game_id = ""

	var/list/c = list("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
	var/l = c.len

	var/t = world.timeofday
	for(var/_ = 1 to 4)
		GLOB.game_id = "[c[(t % l) + 1]][GLOB.game_id]"
		t = round(t / l)
	GLOB.game_id = "-[GLOB.game_id]"
	t = round(world.realtime / (10 * 60 * 60 * 24))
	for(var/_ = 1 to 3)
		GLOB.game_id = "[c[(t % l) + 1]][GLOB.game_id]"
		t = round(t / l)
	return 1

// Find mobs matching a given string
//
// search_string: the string to search for, in params format; for example, "some_key;mob_name"
// restrict_type: A mob type to restrict the search to, or null to not restrict
//
// Partial matches will be found, but exact matches will be preferred by the search
//
// Returns: A possibly-empty list of the strongest matches
/proc/text_find_mobs(search_string, restrict_type = null)
	var/list/search = params2list(search_string)
	var/list/ckeysearch = list()
	for(var/text in search)
		ckeysearch += ckey(text)

	var/list/match = list()

	for(var/mob/M in GLOB.mob_list)
		if(restrict_type && !istype(M, restrict_type))
			continue
		var/strings = list(M.name, M.ckey)
		if(M.mind)
			strings += M.mind.assigned_role
			strings += M.mind.special_role
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(H.species)
				strings += H.species.name
		for(var/text in strings)
			if(ckey(text) in ckeysearch)
				match[M] += 10 // an exact match is far better than a partial one
			else
				for(var/searchstr in search)
					if(findtext(text, searchstr))
						match[M] += 1

	var/maxstrength = 0
	for(var/mob/M in match)
		maxstrength = max(match[M], maxstrength)
	for(var/mob/M in match)
		if(match[M] < maxstrength)
			match -= M

	return match

#define RECOMMENDED_VERSION 511
/world/New()
	//set window title
	name = "[GLOB.server_name] - [GLOB.using_map.full_name]"

	//logs
	var/date_string = time2text(world.realtime, "YYYY/MM-Month/DD-Day")
	GLOB.href_logfile = file("data/logs/[date_string] hrefs.htm")
	GLOB.diary = file("data/logs/[date_string].log")
	to_file(GLOB.diary, "[GLOB.log_end]\n[GLOB.log_end]\nStarting up. (ID: [GLOB.game_id]) [time2text(world.timeofday, "hh:mm.ss")][GLOB.log_end]\n---------------------[GLOB.log_end]")
	GLOB.changelog_hash = md5('html/changelog.html')					//used for telling if the changelog has changed recently

	if(byond_version < RECOMMENDED_VERSION)
		to_world_log("Your server's byond version does not meet the recommended requirements for this server. Please update BYOND")

	TgsNew(minimum_required_security_level = TGS_SECURITY_TRUSTED)

	GLOB.config.post_load()

	if(GLOB.config && GLOB.config.server_name != null && GLOB.config.server_suffix && world.port > 0)
		// dumb and hardcoded but I don't care~
		GLOB.config.server_name += " #[(world.port % 1000) / 100]"

	if(GLOB.config && GLOB.config.log_runtime)
		var/runtime_log = file("data/logs/runtime/[date_string]_[time2text(world.timeofday, "hh:mm")]_[GLOB.game_id].log")
		to_file(runtime_log, "Game [GLOB.game_id] starting up at [time2text(world.timeofday, "hh:mm.ss")]")
		log = runtime_log

	callHook("startup")
	//Emergency Fix
	load_mods()
	//end-emergency fix

	src.update_status()

	. = ..()

#ifdef UNIT_TEST
	log_unit_test("Unit Tests Enabled.  This will destroy the world when testing is complete.")
	load_unit_test_changes()
#endif

	// Set up roundstart seed list.
	GLOB.plant_controller = new()

	if(GLOB.config.generate_map)
		if(GLOB.using_map.perform_map_generation())
			GLOB.using_map.refresh_mining_turfs()

	// Create autolathe recipes, as above.
	populate_lathe_recipes()

	// Create robolimbs for chargen.
	populate_robolimb_list()

	GLOB.processScheduler = new
	GLOB.master_controller = new /datum/controller/game_controller()

	Master.Initialize(10, FALSE)

	spawn(1)
		GLOB.processScheduler.deferSetupFor(/datum/controller/process/ticker)
		GLOB.processScheduler.setup()
		GLOB.master_controller.setup()
#ifdef UNIT_TEST
		initialize_unit_tests()
#endif



	spawn(2000)		//so we aren't adding to the round-start lag
		if(GLOB.config.ToRban)
			ToRban_autoupdate()

	TgsInitializationComplete()

#undef RECOMMENDED_VERSION

GLOBAL_VAR_INIT(world_topic_spam_protect_ip, "0.0.0.0")
GLOBAL_VAR_INIT(world_topic_spam_protect_time, world.timeofday)

/world/Topic(T, addr, master, key)
	TGS_TOPIC	//redirect to server tools if necessary
	to_file(GLOB.diary, "TOPIC: \"[T]\", from:[addr], master:[master], key:[key][GLOB.log_end]")

	if (T == "ping")
		var/x = 1
		for (var/client/C)
			x++
		return x

	else if(T == "players")
		var/n = 0
		for(var/mob/M in GLOB.player_list)
			if(M.client)
				n++
		return n

	else if (copytext(T,1,7) == "status")
		var/input[] = params2list(T)
		var/list/s = list()
		s["version"] = GLOB.game_version
		s["mode"] = PUBLIC_GAME_MODE
		s["respawn"] = GLOB.config.abandon_allowed
		s["enter"] = GLOB.config.enter_allowed
		s["vote"] = GLOB.config.allow_vote_mode
		s["ai"] = GLOB.config.allow_ai
		s["host"] = host ? host : null

		// This is dumb, but spacestation13.com's banners break if player count isn't the 8th field of the reply, so... this has to go here.
		s["players"] = 0
		s["stationtime"] = stationtime2text()
		s["roundduration"] = roundduration2text()
		s["map"] = GLOB.using_map.full_name

		if(input["status"] == "2")
			var/list/players = list()
			var/list/admins = list()

			for(var/client/C in GLOB.clients)
				if(C.holder)
					if(C.is_stealthed())
						continue
					admins[C.key] = C.holder.rank
				players += C.key

			s["players"] = players.len
			s["playerlist"] = list2params(players)
			s["admins"] = admins.len
			s["adminlist"] = list2params(admins)
		else
			var/n = 0
			var/admins = 0

			for(var/client/C in GLOB.clients)
				if(C.holder)
					if(C.is_stealthed())
						continue	//so stealthmins aren't revealed by the hub
					admins++
				s["player[n]"] = C.key
				n++

			s["players"] = n
			s["admins"] = admins

		return list2params(s)

	else if(T == "manifest")
		GLOB.data_core.get_manifest_list()
		var/list/positions = list()

		// We rebuild the list in the format external tools expect
		for(var/dept in GLOB.PDA_Manifest)
			var/list/dept_list = GLOB.PDA_Manifest[dept]
			if(dept_list.len > 0)
				positions[dept] = list()
				for(var/list/person in dept_list)
					positions[dept][person["name"]] = person["rank"]

		for(var/k in positions)
			positions[k] = list2params(positions[k]) // converts positions["heads"] = list("Bob"="Captain", "Bill"="CMO") into positions["heads"] = "Bob=Captain&Bill=CMO"

		return list2params(positions)

	else if(T == "revision")
		var/list/L = list()
		L["gameid"] = GLOB.game_id
		L["dm_version"] = DM_VERSION // DreamMaker version compiled in
		L["dd_version"] = world.byond_version // DreamDaemon version running on

		if(GLOB.revdata.revision)
			L["revision"] = GLOB.revdata.revision
			L["branch"] = GLOB.revdata.branch
			L["date"] = GLOB.revdata.date
		else
			L["revision"] = "unknown"

		return list2params(L)

	else if(copytext(T,1,5) == "laws")
		var/input[] = params2list(T)
		if(input["key"] != GLOB.config.comms_password)
			if(GLOB.world_topic_spam_protect_ip == addr && abs(GLOB.world_topic_spam_protect_time - world.time) < 50)

				spawn(50)
					GLOB.world_topic_spam_protect_time = world.time
					return "Bad Key (Throttled)"

			GLOB.world_topic_spam_protect_time = world.time
			GLOB.world_topic_spam_protect_ip = addr

			return "Bad Key"

		var/list/match = text_find_mobs(input["laws"], /mob/living/silicon)

		if(!match.len)
			return "No matches"
		else if(match.len == 1)
			var/mob/living/silicon/S = match[1]
			var/info = list()
			info["name"] = S.name
			info["key"] = S.key

			if(!S.laws)
				info["laws"] = null
				return list2params(info)

			var/list/lawset_parts = list(
				"ion" = S.laws.ion_laws,
				"inherent" = S.laws.inherent_laws,
				"supplied" = S.laws.supplied_laws
			)

			for(var/law_type in lawset_parts)
				var/laws = list()
				for(var/datum/ai_law/L in lawset_parts[law_type])
					laws += L.law
				info[law_type] = list2params(laws)

			info["zero"] = S.laws.zeroth_law ? S.laws.zeroth_law.law : null

			return list2params(info)

		else
			var/list/ret = list()
			for(var/mob/M in match)
				ret[M.key] = M.name
			return list2params(ret)

	else if(copytext(T,1,5) == "info")
		var/input[] = params2list(T)
		if(input["key"] != GLOB.config.comms_password)
			if(GLOB.world_topic_spam_protect_ip == addr && abs(GLOB.world_topic_spam_protect_time - world.time) < 50)

				spawn(50)
					GLOB.world_topic_spam_protect_time = world.time
					return "Bad Key (Throttled)"

			GLOB.world_topic_spam_protect_time = world.time
			GLOB.world_topic_spam_protect_ip = addr

			return "Bad Key"

		var/list/match = text_find_mobs(input["info"])

		if(!match.len)
			return "No matches"
		else if(match.len == 1)
			var/mob/M = match[1]
			var/info = list()
			info["key"] = M.key
			info["name"] = M.name == M.real_name ? M.name : "[M.name] ([M.real_name])"
			info["role"] = M.mind ? (M.mind.assigned_role ? M.mind.assigned_role : "No role") : "No mind"
			var/turf/MT = get_turf(M)
			info["loc"] = M.loc ? "[M.loc]" : "null"
			info["turf"] = MT ? "[MT] @ [MT.x], [MT.y], [MT.z]" : "null"
			info["area"] = MT ? "[MT.loc]" : "null"
			info["antag"] = M.mind ? (M.mind.special_role ? M.mind.special_role : "Not antag") : "No mind"
			info["hasbeenrev"] = M.mind ? M.mind.has_been_rev : "No mind"
			info["stat"] = M.stat
			info["type"] = M.type
			if(isliving(M))
				var/mob/living/L = M
				info["damage"] = list2params(list(
							oxy = L.getOxyLoss(),
							tox = L.getToxLoss(),
							fire = L.getFireLoss(),
							brute = L.getBruteLoss(),
							clone = L.getCloneLoss(),
							brain = L.getBrainLoss()
						))
				if(ishuman(M))
					var/mob/living/carbon/human/H = M
					info["species"] = H.species.name
				else
					info["species"] = "non-human"
			else
				info["damage"] = "non-living"
				info["species"] = "non-human"
			info["gender"] = M.gender
			return list2params(info)
		else
			var/list/ret = list()
			for(var/mob/M in match)
				ret[M.key] = M.name
			return list2params(ret)

	else if(copytext(T,1,9) == "adminmsg")
		/*
			We got an adminmsg from IRC bot lets split the input then validate the input.
			expected output:
				1. adminmsg = ckey of person the message is to
				2. msg = contents of message, parems2list requires
				3. validatationkey = the key the bot has, it should match the gameservers commspassword in it's configuration.
				4. sender = the ircnick that send the message.
		*/


		var/input[] = params2list(T)
		if(input["key"] != GLOB.config.comms_password)
			if(GLOB.world_topic_spam_protect_ip == addr && abs(GLOB.world_topic_spam_protect_time - world.time) < 50)

				spawn(50)
					GLOB.world_topic_spam_protect_time = world.time
					return "Bad Key (Throttled)"

			GLOB.world_topic_spam_protect_time = world.time
			GLOB.world_topic_spam_protect_ip = addr

			return "Bad Key"

		var/client/C
		var/req_ckey = ckey(input["adminmsg"])

		for(var/client/K in GLOB.clients)
			if(K.ckey == req_ckey)
				C = K
				break
		if(!C)
			return "No client with that name on server"

		var/rank = input["rank"]
		if(!rank)
			rank = "Admin"
		if(rank == "Unknown")
			rank = "Staff"

		var/message =	"<font color='red'>[rank] PM from <b><a href='?irc_msg=[input["sender"]]'>[input["sender"]]</a></b>: [input["msg"]]</font>"
		var/amessage =  "<font color='blue'>[rank] PM from <a href='?irc_msg=[input["sender"]]'>[input["sender"]]</a> to <b>[key_name(C)]</b> : [input["msg"]]</font>"

		C.received_irc_pm = world.time
		C.irc_admin = input["sender"]

		sound_to(C, 'sound/effects/adminhelp.ogg')
		to_chat(C, message)

		for(var/client/A in GLOB.admins)
			if(A != C)
				to_chat(A, amessage)
		return "Message Successful"

	else if(copytext(T,1,6) == "notes")
		/*
			We got a request for notes from the IRC Bot
			expected output:
				1. notes = ckey of person the notes lookup is for
				2. validationkey = the key the bot has, it should match the gameservers commspassword in it's configuration.
		*/
		var/input[] = params2list(T)
		if(input["key"] != GLOB.config.comms_password)
			if(GLOB.world_topic_spam_protect_ip == addr && abs(GLOB.world_topic_spam_protect_time - world.time) < 50)

				spawn(50)
					GLOB.world_topic_spam_protect_time = world.time
					return "Bad Key (Throttled)"

			GLOB.world_topic_spam_protect_time = world.time
			GLOB.world_topic_spam_protect_ip = addr
			return "Bad Key"

		return show_player_info_irc(ckey(input["notes"]))

	else if(copytext(T,1,4) == "age")
		var/input[] = params2list(T)
		if(input["key"] != GLOB.config.comms_password)
			if(GLOB.world_topic_spam_protect_ip == addr && abs(GLOB.world_topic_spam_protect_time - world.time) < 50)
				spawn(50)
					GLOB.world_topic_spam_protect_time = world.time
					return "Bad Key (Throttled)"

			GLOB.world_topic_spam_protect_time = world.time
			GLOB.world_topic_spam_protect_ip = addr
			return "Bad Key"

		var/age = get_player_age(input["age"])
		if(isnum(age))
			if(age >= 0)
				return "[age]"
			else
				return "Ckey not found"
		else
			return "Database connection failed or not set up"

	else if(copytext(T,1,14) == "placepermaban")
		var/input[] = params2list(T)
		if(!GLOB.config.ban_comms_password)
			return "Not enabled"
		if(input["bankey"] != GLOB.config.ban_comms_password)
			if(GLOB.world_topic_spam_protect_ip == addr && abs(GLOB.world_topic_spam_protect_time - world.time) < 50)
				spawn(50)
					GLOB.world_topic_spam_protect_time = world.time
					return "Bad Key (Throttled)"

			GLOB.world_topic_spam_protect_time = world.time
			GLOB.world_topic_spam_protect_ip = addr
			return "Bad Key"

		var/target = ckey(input["target"])

		var/client/C
		for(var/client/K in GLOB.clients)
			if(K.ckey == target)
				C = K
				break
		if(!C)
			return "No client with that name found on server"
		if(!C.mob)
			return "Client missing mob"

		if(!_DB_ban_record(input["id"], "0", "127.0.0.1", 1, C.mob, -1, input["reason"]))
			return "Save failed"
		ban_unban_log_save("[input["id"]] has permabanned [C.ckey]. - Reason: [input["reason"]] - This is a ban until appeal.")
		notes_add(target,"[input["id"]] has permabanned [C.ckey]. - Reason: [input["reason"]] - This is a ban until appeal.",input["id"])
		qdel(C)


/world/Reboot(var/reason)
	/*spawn(0)
		sound_to(world, sound(pick('sound/AI/newroundsexy.ogg','sound/misc/apcdestroyed.ogg','sound/misc/bangindonk.ogg')))// random end sounds!! - LastyBatsy

		*/

	GLOB.processScheduler.stop()

	TgsReboot()

	if(GLOB.config.server)	//if you set a server location in GLOB.config.txt, it sends you there instead of trying to reconnect to the same world address. -- NeoFite
		for(var/client/C in GLOB.clients)
			to_chat(C, link("byond://[GLOB.config.server]"))

	if(GLOB.config.wait_for_sigusr1_reboot && reason != 3)
		text2file("foo", "reboot_called")
		to_world("<span class=danger>World reboot waiting for external scripts. Please be patient.</span>")
		return

	..(reason)

/world/Del()
	callHook("shutdown")
	return ..()

/hook/startup/proc/loadMode()
	world.load_mode()
	return 1

/world/proc/load_mode()
	if(!fexists("data/mode.txt"))
		return

	var/list/Lines = file2list("data/mode.txt")
	if(Lines.len)
		if(Lines[1])
			GLOB.master_mode = Lines[1]
			log_misc("Saved mode is '[GLOB.master_mode]'")

/world/proc/save_mode(var/the_mode)
	var/F = file("data/mode.txt")
	fdel(F)
	to_file(F, the_mode)

/hook/startup/proc/loadMOTD()
	world.load_motd()
	return 1

/world/proc/load_motd()
	GLOB.join_motd = file2text("config/motd.txt")


/proc/load_configuration()
	GLOB.config = new /datum/configuration()
	GLOB.config.load("config/config.txt")
	GLOB.config.load("config/game_options.txt","game_options")
	GLOB.config.loadsql("config/dbconfig.txt")
	GLOB.config.loadforumsql("config/forumdbconfig.txt")

/hook/startup/proc/loadMods()
	world.load_mods()
	world.load_mentors() // no need to write another hook.
	return 1

/world/proc/load_mods()
	if(GLOB.config.admin_legacy_system)
		var/text = file2text("config/moderators.txt")
		if (!text)
			error("Failed to load config/mods.txt")
		else
			var/list/lines = splittext(text, "\n")
			for(var/line in lines)
				if (!line)
					continue

				if (copytext(line, 1, 2) == ";")
					continue

				var/title = "Moderator"
				var/rights = GLOB.admin_ranks[title]

				var/ckey = copytext(line, 1, length(line)+1)
				var/datum/admins/D = new /datum/admins(title, rights, ckey)
				D.associate(GLOB.directory[ckey])

/world/proc/load_mentors()
	if(GLOB.config.admin_legacy_system)
		var/text = file2text("config/mentors.txt")
		if (!text)
			error("Failed to load config/mentors.txt")
		else
			var/list/lines = splittext(text, "\n")
			for(var/line in lines)
				if (!line)
					continue
				if (copytext(line, 1, 2) == ";")
					continue

				var/title = "Mentor"
				var/rights = GLOB.admin_ranks[title]

				var/ckey = copytext(line, 1, length(line)+1)
				var/datum/admins/D = new /datum/admins(title, rights, ckey)
				D.associate(GLOB.directory[ckey])

/world/proc/update_status()
	var/s = ""

	if (GLOB.config && GLOB.config.server_name)
		s += "<b>[GLOB.config.server_name]</b> &#8212; "

	s += "<b>[station_name()]</b>";
	s += " ("
	s += "<a href=\"http://\">" //Change this to wherever you want the hub to link to.
//	s += "[GLOB.game_version]"
	s += "Default"  //Replace this with something else. Or ever better, delete it and uncomment the game version.
	s += "</a>"
	s += ")"

	var/list/features = list()

	if(GLOB.ticker)
		if(GLOB.master_mode)
			features += GLOB.master_mode
	else
		features += "<b>STARTING</b>"

	if (!GLOB.config.enter_allowed)
		features += "closed"

	features += GLOB.config.abandon_allowed ? "respawn" : "no respawn"

	if (GLOB.config && GLOB.config.allow_vote_mode)
		features += "vote"

	if (GLOB.config && GLOB.config.allow_ai)
		features += "AI allowed"

	var/n = 0
	for (var/mob/M in GLOB.player_list)
		if (M.client)
			n++

	if (n > 1)
		features += "~[n] players"
	else if (n > 0)
		features += "~[n] player"


	if (GLOB.config && GLOB.config.hostedby)
		features += "hosted by <b>[GLOB.config.hostedby]</b>"

	if (features)
		s += ": [jointext(features, ", ")]"

	/* does this help? I do not know */
	if (src.status != s)
		src.status = s

/world/proc/set_hub_visibility(var/display_in_hub)
	if(visibility == display_in_hub)
		return
	visibility = display_in_hub

/world/proc/change_fps(new_value = 20)
	if(new_value <= 0)
		CRASH("change_fps() called with [new_value] new_value.")
	if(fps == new_value)
		return //No change required.

	fps = new_value
	on_tickrate_change()

/world/proc/on_tickrate_change()
	return

#define FAILED_DB_CONNECTION_CUTOFF 5
GLOBAL_VAR_INIT(failed_db_connections, 0)
GLOBAL_VAR_INIT(failed_old_db_connections, 0)

/hook/startup/proc/connectDB()
	if(!setup_database_connection())
		to_world_log("Your server failed to establish a connection with the feedback database.")
	else
		to_world_log("Feedback database connection established.")
	return 1

proc/setup_database_connection()

	if(GLOB.failed_db_connections > FAILED_DB_CONNECTION_CUTOFF)	//If it failed to establish a connection more than 5 times in a row, don't bother attempting to conenct anymore.
		return 0

	if(!GLOB.dbcon)
		GLOB.dbcon = new()

	var/user = sqlfdbklogin
	var/pass = sqlfdbkpass
	var/db = sqlfdbkdb
	var/address = sqladdress
	var/port = sqlport

	GLOB.dbcon.Connect("dbi:mysql:[db]:[address]:[port]","[user]","[pass]")
	. = GLOB.dbcon.IsConnected()
	if ( . )
		GLOB.failed_db_connections = 0	//If this connection succeeded, reset the failed connections counter.
	else
		GLOB.failed_db_connections++		//If it failed, increase the failed connections counter.
		to_world_log(GLOB.dbcon.ErrorMsg())

	return .

//This proc ensures that the connection to the feedback database (global variable dbcon) is established
proc/establish_db_connection()
	if(GLOB.failed_db_connections > FAILED_DB_CONNECTION_CUTOFF)
		return 0

	if(!GLOB.dbcon || !GLOB.dbcon.IsConnected())
		return setup_database_connection()
	else
		return 1


/hook/startup/proc/connectOldDB()
	if(!setup_old_database_connection())
		to_world_log("Your server failed to establish a connection with the SQL database.")
	else
		to_world_log("SQL database connection established.")
	return 1

//These two procs are for the old database, while it's being phased out. See the tgstation.sql file in the SQL folder for more information.
proc/setup_old_database_connection()

	if(GLOB.failed_old_db_connections > FAILED_DB_CONNECTION_CUTOFF)	//If it failed to establish a connection more than 5 times in a row, don't bother attempting to conenct anymore.
		return 0

	if(!GLOB.dbcon_old)
		GLOB.dbcon_old = new()

	var/user = sqllogin
	var/pass = sqlpass
	var/db = sqldb
	var/address = sqladdress
	var/port = sqlport

	GLOB.dbcon_old.Connect("dbi:mysql:[db]:[address]:[port]","[user]","[pass]")
	. = GLOB.dbcon_old.IsConnected()
	if ( . )
		GLOB.failed_old_db_connections = 0	//If this connection succeeded, reset the failed connections counter.
	else
		GLOB.failed_old_db_connections++		//If it failed, increase the failed connections counter.
		to_world_log(GLOB.dbcon.ErrorMsg())

	return .

//This proc ensures that the connection to the feedback database (global variable dbcon) is established
proc/establish_old_db_connection()
	if(GLOB.failed_old_db_connections > FAILED_DB_CONNECTION_CUTOFF)
		return 0

	if(!GLOB.dbcon_old || !GLOB.dbcon_old.IsConnected())
		return setup_old_database_connection()
	else
		return 1

#undef FAILED_DB_CONNECTION_CUTOFF

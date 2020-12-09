//#define TESTING
#if DM_VERSION < 509
#warn This compiler is out of date. You may experience issues with projectile animations.
#endif

// Items that ask to be called every cycle.
var/global/datum/datacore/data_core = null

GLOBAL_LIST_EMPTY(processing_objects)
GLOBAL_LIST_EMPTY(processing_power_items)
// GLOBAL_LIST_EMPTY(active_diseases)
GLOBAL_LIST_EMPTY(med_hud_users) // List of all entities using a medical HUD.
GLOBAL_LIST_EMPTY(sec_hud_users) // List of all entities using a security HUD.
GLOBAL_LIST_EMPTY(hud_icon_reference)
GLOBAL_LIST_EMPTY(traders) //List of all nearby GLOB.traders

GLOBAL_LIST_EMPTY(listening_objects) // List of objects that need to be able to hear, used to avoid recursive searching through contents.


// GLOBAL_LIST_EMPTY(global_mutations) // List of hidden mutation things.

var/global/datum/universal_state/universe = new

GLOBAL_LIST_EMPTY(global_map)

// Noises made when hit while typing.
GLOBAL_LIST_INIT(hit_appends, list("-OOF", "-ACK", "-UGH", "-HRNK", "-HURGH", "-GLORF"))


GLOBAL_VAR_INIT(diary, null) 
GLOBAL_VAR_INIT(href_logfile, null) 
GLOBAL_VAR_INIT(game_version, "Baystation12") 
GLOBAL_VAR_INIT(changelog_hash, "") 
GLOBAL_VAR_INIT(game_year, (text2num(time2text(world.realtime, "YYYY")) + 544)) 
GLOBAL_VAR_INIT(station_name, "Baystation12") 

GLOBAL_VAR_INIT(round_progressing, 1) 
GLOBAL_VAR_INIT(master_mode, "extended") // "extended"
GLOBAL_VAR_INIT(secondary_mode, "extended") 
GLOBAL_VAR_INIT(tertiary_mode, "extended") 
GLOBAL_VAR_INIT(secret_force_mode, "secret") // if this is anything but "secret", the secret rotation will forceably choose this mode.

GLOBAL_VAR_INIT(hostName, null) //only here until check @ code\modules\ghosttrap\trap.dm:112 is fixed

// GLOBAL_LIST_EMPTY(jobMax)
GLOBAL_LIST_EMPTY(bombers)
GLOBAL_LIST_EMPTY(admin_log)
GLOBAL_LIST_EMPTY(lastsignalers) // Keeps last 100 signals here in format: "[src] used \ref[src] @ location [src.loc]: [freq]/[code]"
GLOBAL_LIST_EMPTY(lawchanges) // Stores who uploaded laws to which silicon-based lifeform, and what the law was.
GLOBAL_LIST_EMPTY(reg_dna)

GLOBAL_LIST_EMPTY(monkeystart)
// GLOBAL_LIST_EMPTY(wizardstart)
GLOBAL_LIST_EMPTY(newplayer_start)

//Spawnpoints.
GLOBAL_LIST_EMPTY(latejoin)
GLOBAL_LIST_EMPTY(latejoin_gateway)
GLOBAL_LIST_EMPTY(latejoin_cryo)
GLOBAL_LIST_EMPTY(latejoin_cyborg)

GLOBAL_LIST_EMPTY(prisonwarp) // Prisoners go to these
GLOBAL_LIST_EMPTY(xeno_spawn) // Aliens spawn at at these.
GLOBAL_LIST_EMPTY(tdome1)
GLOBAL_LIST_EMPTY(tdome2)
GLOBAL_LIST_EMPTY(tdomeobserve)
GLOBAL_LIST_EMPTY(tdomeadmin)
GLOBAL_LIST_EMPTY(prisonsecuritywarp) // Prison security goes to these.
GLOBAL_LIST_EMPTY(prisonwarped) // List of players already warped.
// GLOBAL_LIST_EMPTY(ninjastart)

GLOBAL_LIST_INIT(cardinal, list(NORTH, SOUTH, EAST, WEST))
GLOBAL_LIST_INIT(cardinalz, list(NORTH, SOUTH, EAST, WEST, UP, DOWN))
GLOBAL_LIST_INIT(cornerdirs, list(NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST))
GLOBAL_LIST_INIT(cornerdirsz, list(NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST, NORTH|UP, EAST|UP, WEST|UP, SOUTH|UP, NORTH|DOWN, EAST|DOWN, WEST|DOWN, SOUTH|DOWN))
GLOBAL_LIST_INIT(alldirs, list(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST))
GLOBAL_LIST_INIT(reverse_dir, list( // reverse_dir[dir] = reverse of dir
	 2,  1,  3,  8, 10,  9, 11,  4,  6,  5,  7, 12, 14, 13, 15, 32, 34, 33, 35, 40, 42,
	41, 43, 36, 38, 37, 39, 44, 46, 45, 47, 16, 18, 17, 19, 24, 26, 25, 27, 20, 22, 21,
	23, 28, 30, 29, 31, 48, 50, 49, 51, 56, 58, 57, 59, 52, 54, 53, 55, 60, 62, 61, 63
))

GLOBAL_LIST_INIT(bitflags, list(1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768))

var/datum/configuration/config      = null
var/datum/sun/sun                   = null

// GLOBAL_LIST_EMPTY(combatlog)
// GLOBAL_LIST_EMPTY(IClog)
// GLOBAL_LIST_EMPTY(OOClog)
// GLOBAL_LIST_EMPTY(adminlog)

GLOBAL_LIST_EMPTY(powernets)

GLOBAL_VAR_INIT(Debug2, 0) 

GLOBAL_VAR_INIT(gravity_is_on, 1) 

GLOBAL_VAR_INIT(join_motd, null) 

var/datum/nanomanager/nanomanager		= new() // NanoManager, the manager for Nano UIs.
var/datum/event_manager/event_manager	= new() // Event Manager, the manager for events.

GLOBAL_LIST_EMPTY(awaydestinations) // Away missions. A list of landmarks that the warpgate can take you to.

// MySQL configuration
GLOBAL_REAL_VAR(sqladdress) = "localhost"
GLOBAL_REAL_VAR(sqlport) = "3306"
GLOBAL_REAL_VAR(sqldb) = "tgstation"
GLOBAL_REAL_VAR(sqllogin) = "root"
GLOBAL_REAL_VAR(sqlpass) = "" // Feedback gathering sql connection
GLOBAL_REAL_VAR(sqlfdbkdb) = "test"
GLOBAL_REAL_VAR(sqlfdbklogin) = "root"
GLOBAL_REAL_VAR(sqlfdbkpass) = ""
GLOBAL_REAL_VAR(sqllogging) = 0 // Should we log deaths, population stats, etc.?

// Forum MySQL configuration. (for use with forum account/key authentication)
// These are all default values that will load should the forumdbconfig.txt file fail to read for whatever reason.
GLOBAL_REAL_VAR(forumsqladdress) = "localhost"
GLOBAL_REAL_VAR(forumsqlport) = "3306"
GLOBAL_REAL_VAR(forumsqldb) = "tgstation"
GLOBAL_REAL_VAR(forumsqllogin) = "root"
GLOBAL_REAL_VAR(forumsqlpass) = ""
GLOBAL_REAL_VAR(forum_activated_group) = "2"
GLOBAL_REAL_VAR(forum_authenticated_group) = "10" // For FTP requests. (i.e. downloading runtime logs.)
// However it'd be ok to use for accessing attack logs and such too, which are even laggier.
GLOBAL_VAR_INIT(fileaccess_timer, 0) 
GLOBAL_VAR_INIT(custom_event_msg, null) // Database connections. A connection is established on world creation.
// Ideally, the connection dies when the server restarts (After feedback logging.).
var/DBConnection/dbcon     = new() // Feedback    database (New database)
var/DBConnection/dbcon_old = new() // /tg/station database (Old database) -- see the files in the SQL folder for information on what goes where.

// Reference list for disposal sort junctions. Filled up by sorting junction's New()
GLOBAL_LIST_EMPTY(tagger_locations)

// Added for Xenoarchaeology, might be useful for other stuff.
GLOBAL_LIST_INIT(alphabet_uppercase, list("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"))


// Used by robots and robot preferences.
GLOBAL_LIST_INIT(robot_module_types, list(
	"Standard", "Engineering", "Surgeon",  "Crisis",
	"Miner",    "Janitor",     "Service",      "Clerical", "Security",
	"Research"
))

// Some scary sounds.
var/static/list/scarySounds = list(
	'sound/weapons/thudswoosh.ogg',
	'sound/weapons/Taser.ogg',
	'sound/weapons/armbomb.ogg',
	'sound/voice/hiss1.ogg',
	'sound/voice/hiss2.ogg',
	'sound/voice/hiss3.ogg',
	'sound/voice/hiss4.ogg',
	'sound/voice/hiss5.ogg',
	'sound/voice/hiss6.ogg',
	'sound/effects/Glassbr1.ogg',
	'sound/effects/Glassbr2.ogg',
	'sound/effects/Glassbr3.ogg',
	'sound/items/Welder.ogg',
	'sound/items/Welder2.ogg',
	'sound/machines/airlock.ogg',
	'sound/effects/clownstep1.ogg',
	'sound/effects/clownstep2.ogg'
)

// Bomb cap!
GLOBAL_VAR_INIT(max_explosion_range, 14) // Announcer intercom, because too much stuff creates an intercom for one message then hard del()s it. Also headset, for things that should be affected by comms outages.
GLOBAL_DATUM_INIT(global_announcer, /obj/item/device/radio/announcer, new)
GLOBAL_DATUM_INIT(global_headset, /obj/item/device/radio/announcer/subspace, new)

GLOBAL_LIST_INIT(station_departments, list("Command", "Medical", "Engineering", "Science", "Security", "Cargo", "Civilian"))

GLOBAL_LIST_EMPTY(registered_macros_by_ckey_) 
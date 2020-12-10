#define WHITELISTFILE "data/whitelist.txt"

GLOBAL_LIST_EMPTY(whitelist)

/hook/startup/proc/loadWhitelist()
	if(GLOB.config.usewhitelist)
		load_whitelist()
	return 1

/proc/load_whitelist()
	GLOB.whitelist = file2list(WHITELISTFILE)
	if(!GLOB.whitelist.len)	
		GLOB.whitelist = null

/proc/check_whitelist(mob/M /*, var/rank*/)
	if(!GLOB.whitelist)
		return 0
	return ("[M.ckey]" in GLOB.whitelist)

GLOBAL_LIST_EMPTY(alien_whitelist)

/hook/startup/proc/loadAlienWhitelist()
	if(GLOB.config.usealienwhitelist)
		if(GLOB.config.usealienwhitelistSQL)
			if(!load_alienwhitelistSQL())
				to_world_log("Could not load alienwhitelist via SQL")
		else
			load_alienwhitelist()
	return 1
/proc/load_alienwhitelist()
	var/text = file2text("config/alienwhitelist.txt")
	if (!text)
		log_misc("Failed to load config/alienwhitelist.txt")
		return 0
	else
		GLOB.alien_whitelist = splittext(text, "\n")
		return 1
/proc/load_alienwhitelistSQL()
	var/DBQuery/query = GLOB.dbcon_old.NewQuery("SELECT * FROM whitelist")
	if(!query.Execute())
		to_world_log(GLOB.dbcon_old.ErrorMsg())
		return 0
	else
		while(query.NextRow())
			var/list/row = query.GetRowData()
			if(GLOB.alien_whitelist[row["ckey"]])
				var/list/A = GLOB.alien_whitelist[row["ckey"]]
				A.Add(row["race"])
			else
				GLOB.alien_whitelist[row["ckey"]] = list(row["race"])
	return 1

/proc/is_species_whitelisted(mob/M, var/species_name)
	var/datum/species/S = GLOB.all_species[species_name]
	return is_alien_whitelisted(M, S)

//todo: admin aliens
/proc/is_alien_whitelisted(mob/M, var/species)
	if(!M || !species)
		return 0
	if(!GLOB.config.usealienwhitelist)
		return 1
	if(check_rights(R_ADMIN, 0, M))
		return 1

	if(istype(species,/datum/language))
		var/datum/language/L = species
		if(!(L.flags & (WHITELISTED|RESTRICTED)))
			return 1
		return whitelist_lookup(L.name, M.ckey)

	if(istype(species,/datum/species))
		var/datum/species/S = species
		if(!(S.spawn_flags & (SPECIES_IS_WHITELISTED|SPECIES_IS_RESTRICTED)))
			return 1
		return whitelist_lookup(S.get_bodytype(S), M.ckey)

	return 0

/proc/whitelist_lookup(var/item, var/ckey)
	if(!GLOB.alien_whitelist)
		return 0

	if(GLOB.config.usealienwhitelistSQL)
		//SQL Whitelist
		if(!(ckey in GLOB.alien_whitelist))
			return 0;
		var/list/whitelisted = GLOB.alien_whitelist[ckey]
		if(lowertext(item) in whitelisted)
			return 1
	else
		//Config File Whitelist
		for(var/s in GLOB.alien_whitelist)
			if(findtext(s,"[ckey] - [item]"))
				return 1
			if(findtext(s,"[ckey] - All"))
				return 1
	return 0

#undef WHITELISTFILE

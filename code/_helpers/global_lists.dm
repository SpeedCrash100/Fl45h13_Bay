GLOBAL_LIST_EMPTY(clients)							//list of all GLOB.clients
GLOBAL_LIST_EMPTY(admins)							//list of all GLOB.clients whom are admins
GLOBAL_LIST_EMPTY(directory)							//list of all ckeys with associated client

//Since it didn't really belong in any other category, I'm putting this here
//This is for procs to replace all the goddamn 'in world's that are chilling around the code

GLOBAL_LIST_EMPTY(player_list)				//List of all mobs **with GLOB.clients attached**. Excludes /mob/new_player
GLOBAL_LIST_EMPTY(mob_list)					//List of all mobs, including clientless
GLOBAL_LIST_EMPTY(human_mob_list)				//List of all human mobs and sub-types, including clientless
GLOBAL_LIST_EMPTY(silicon_mob_list)			//List of all silicon mobs, including clientless
GLOBAL_LIST_EMPTY(living_mob_list_)			//List of all alive mobs, including clientless. Excludes /mob/new_player
GLOBAL_LIST_EMPTY(dead_mob_list_)				//List of all dead mobs, including clientless. Excludes /mob/new_player

GLOBAL_LIST_EMPTY(cable_list)					//Index for all cables, so that powernets don't have to look through the entire world all the time
GLOBAL_LIST_EMPTY(chemical_reactions_list) // list of all /datum/chemical_reaction datums. Used during chemical reactions
GLOBAL_LIST_EMPTY(chemical_reagents_list) // list of all /datum/reagent datums indexed by reagent id. Used by chemistry stuff
GLOBAL_LIST_EMPTY(landmarks_list)				//list of all landmarks created
GLOBAL_LIST_EMPTY(surgery_steps)				//list of all surgery steps  |BS12
GLOBAL_LIST_EMPTY(side_effects)				//list of all medical sideeffects types by thier names |BS12
GLOBAL_LIST_EMPTY(mechas_list)				//list of all mechs. Used by hostile mobs target tracking.
GLOBAL_LIST_EMPTY(joblist)					//list of all jobstypes, minus borg and AI

GLOBAL_LIST_EMPTY(turfs)						//list of all GLOB.turfs

#define all_genders_define_list list(MALE,FEMALE,PLURAL,NEUTER)
#define all_genders_text_list list("Male","Female","Plural","Neuter")

//Languages/species/whitelist.
var/global/list/all_species[0]
var/global/list/all_languages[0]
var/global/list/language_keys[0]					// Table of say codes for all languages
GLOBAL_LIST_INIT(whitelisted_species, list(SPECIES_HUMAN)) // Species that require a whitelist check.
GLOBAL_LIST_INIT(playable_species, list(SPECIES_HUMAN))    // A list of ALL playable species, whitelisted, latejoin or otherwise.

GLOBAL_LIST_EMPTY(mannequins_) 
// Posters
GLOBAL_LIST_EMPTY(poster_designs)

// Uplinks
var/list/obj/item/device/uplink/world_uplinks = list()

//Preferences stuff
	//Hairstyles
GLOBAL_LIST_EMPTY(hair_styles_list)			//stores /datum/sprite_accessory/hair indexed by name
GLOBAL_LIST_EMPTY(hair_styles_male_list)
GLOBAL_LIST_EMPTY(hair_styles_female_list)
GLOBAL_LIST_EMPTY(facial_hair_styles_list)	//stores /datum/sprite_accessory/facial_hair indexed by name
GLOBAL_LIST_EMPTY(facial_hair_styles_male_list)
GLOBAL_LIST_EMPTY(facial_hair_styles_female_list)
// GLOBAL_LIST_EMPTY(skin_styles_female_list)		//unused

var/datum/category_collection/underwear/global_underwear = new()

GLOBAL_LIST_INIT(backbaglist, list("Nothing", "Backpack", "Satchel", "Brown Satchel", "Messenger Bag", "Black Satchel"))
GLOBAL_LIST_INIT(exclude_jobs, list(/datum/job/ai,/datum/job/cyborg))

// Visual nets
var/list/datum/visualnet/visual_nets = list()
var/datum/visualnet/camera/cameranet = new()

// Runes
var/global/list/rune_list = new()
GLOBAL_LIST_EMPTY(endgame_exits)
GLOBAL_LIST_EMPTY(endgame_safespawns)

GLOBAL_LIST_INIT(syndicate_access, list(access_maint_tunnels, access_syndicate, access_external_airlocks))

// Strings which corraspond to bodypart covering flags, useful for outputting what something covers.
var/global/list/string_part_flags = list(
	"head" = HEAD,
	"face" = FACE,
	"eyes" = EYES,
	"upper body" = UPPER_TORSO,
	"lower body" = LOWER_TORSO,
	"legs" = LEGS,
	"feet" = FEET,
	"arms" = ARMS,
	"hands" = HANDS
)

// Strings which corraspond to slot flags, useful for outputting what slot something is.
var/global/list/string_slot_flags = list(
	"back" = SLOT_BACK,
	"face" = SLOT_MASK,
	"waist" = SLOT_BELT,
	"ID slot" = SLOT_ID,
	"ears" = SLOT_EARS,
	"eyes" = SLOT_EYES,
	"hands" = SLOT_GLOVES,
	"head" = SLOT_HEAD,
	"feet" = SLOT_FEET,
	"exo slot" = SLOT_OCLOTHING,
	"body" = SLOT_ICLOTHING,
	"uniform" = SLOT_TIE,
	"holster" = SLOT_HOLSTER
)

//////////////////////////
/////Initial Building/////
//////////////////////////

/hook/global_init/proc/populateGlobalLists()
	GLOB.possible_cable_coil_colours = sortAssoc(list(
		"Yellow" = COLOR_YELLOW,
		"Green" = COLOR_LIME,
		"Pink" = COLOR_PINK,
		"Blue" = COLOR_BLUE,
		"Orange" = COLOR_ORANGE,
		"Cyan" = COLOR_CYAN,
		"Red" = COLOR_RED,
		"White" = COLOR_WHITE
	))
	return 1

/proc/get_mannequin(var/ckey)
	if(!GLOB.mannequins_)
		GLOB.mannequins_ = new()
	. = GLOB.mannequins_[ckey]
	if(!.)
		. = new/mob/living/carbon/human/dummy/mannequin()
		GLOB.mannequins_[ckey] = .

/hook/global_init/proc/makeDatumRefLists()
	var/list/paths

	//Hair - Initialise all /datum/sprite_accessory/hair into an list indexed by hair-style name
	paths = typesof(/datum/sprite_accessory/hair) - /datum/sprite_accessory/hair
	for(var/path in paths)
		var/datum/sprite_accessory/hair/H = new path()
		GLOB.hair_styles_list[H.name] = H
		switch(H.gender)
			if(MALE)	GLOB.hair_styles_male_list += H.name
			if(FEMALE)	GLOB.hair_styles_female_list += H.name
			else
				GLOB.hair_styles_male_list += H.name
				GLOB.hair_styles_female_list += H.name

	//Facial Hair - Initialise all /datum/sprite_accessory/facial_hair into an list indexed by facialhair-style name
	paths = typesof(/datum/sprite_accessory/facial_hair) - /datum/sprite_accessory/facial_hair
	for(var/path in paths)
		var/datum/sprite_accessory/facial_hair/H = new path()
		GLOB.facial_hair_styles_list[H.name] = H
		switch(H.gender)
			if(MALE)	GLOB.facial_hair_styles_male_list += H.name
			if(FEMALE)	GLOB.facial_hair_styles_female_list += H.name
			else
				GLOB.facial_hair_styles_male_list += H.name
				GLOB.facial_hair_styles_female_list += H.name

	//Surgery Steps - Initialize all /datum/surgery_step into a list
	paths = typesof(/datum/surgery_step)-/datum/surgery_step
	for(var/T in paths)
		var/datum/surgery_step/S = new T
		GLOB.surgery_steps += S
	sort_surgeries()

	//List of job. I can't believe this was calculated multiple times per tick!
	paths = typesof(/datum/job)-/datum/job
	paths -= GLOB.exclude_jobs
	for(var/T in paths)
		var/datum/job/J = new T
		GLOB.joblist[J.title] = J

	//Languages and species.
	paths = typesof(/datum/language)-/datum/language
	for(var/T in paths)
		var/datum/language/L = new T
		all_languages[L.name] = L

	for (var/language_name in all_languages)
		var/datum/language/L = all_languages[language_name]
		if(!(L.flags & NONGLOBAL))
			language_keys[lowertext(L.key)] = L

	var/rkey = 0
	paths = typesof(/datum/species)
	for(var/T in paths)

		rkey++

		var/datum/species/S = T
		if(!initial(S.name))
			continue

		S = new T
		S.race_key = rkey //Used in mob icon caching.
		all_species[S.name] = S

		if(!(S.spawn_flags & SPECIES_IS_RESTRICTED))
			playable_species += S.name
		if(S.spawn_flags & SPECIES_IS_WHITELISTED)
			whitelisted_species += S.name

	//Posters
	paths = typesof(/datum/poster) - /datum/poster
	for(var/T in paths)
		var/datum/poster/P = new T
		GLOB.poster_designs += P

	return 1


/* // Uncomment to debug chemical reaction list.
/client/verb/debug_chemical_list()

	for (var/reaction in GLOB.chemical_reactions_list)
		. += "GLOB.chemical_reactions_list\[\"[reaction]\"\] = \"[GLOB.chemical_reactions_list[reaction]]\"\n"
		if(islist(GLOB.chemical_reactions_list[reaction]))
			var/list/L = GLOB.chemical_reactions_list[reaction]
			for(var/t in L)
				. += "    has: [t]\n"
	log_debug(.)

*/

//*** params cache

GLOBAL_LIST_EMPTY(paramslist_cache)

#define cached_key_number_decode(key_number_data) cached_params_decode(key_number_data, /proc/key_number_decode)
#define cached_number_list_decode(number_list_data) cached_params_decode(number_list_data, /proc/number_list_decode)

/proc/cached_params_decode(var/params_data, var/decode_proc)
	. = GLOB.paramslist_cache[params_data]
	if(!.)
		. = call(decode_proc)(params_data)
		GLOB.paramslist_cache[params_data] = .

/proc/key_number_decode(var/key_number_data)
	var/list/L = params2list(key_number_data)
	for(var/key in L)
		L[key] = text2num(L[key])
	return L

/proc/number_list_decode(var/number_list_data)
	var/list/L = params2list(number_list_data)
	for(var/i in 1 to L.len)
		L[i] = text2num(L[i])
	return L

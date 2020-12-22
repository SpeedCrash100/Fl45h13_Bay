GLOBAL_LIST_EMPTY(spawntypes)

/proc/populate_spawn_points()
	GLOB.spawntypes = list()
	for(var/type in typesof(/datum/spawnpoint)-/datum/spawnpoint)
		var/datum/spawnpoint/S = new type()
		if((S.display_name in GLOB.using_map.allowed_spawns) || S.always_visible)
			GLOB.spawntypes[S.display_name] = S

/datum/spawnpoint
	var/msg          //Message to display on the arrivals computer.
	var/list/turfs   //List of GLOB.turfs to spawn on.
	var/display_name //Name used in preference setup.
	var/always_visible = FALSE	// Whether this spawn point is always visible in selection, ignoring map-specific settings.
	var/list/restrict_job = null
	var/list/disallow_job = null

	proc/check_job_spawning(job)
		if(restrict_job && !(job in restrict_job))
			return 0

		if(disallow_job && (job in disallow_job))
			return 0

		return 1

/datum/spawnpoint/arrivals
	display_name = "Arrivals Shuttle"
	msg = "has arrived on the station"

/datum/spawnpoint/arrivals/New()
	..()
	GLOB.turfs = GLOB.latejoin

/datum/spawnpoint/gateway
	display_name = "Gateway"
	msg = "has completed translation from offsite gateway"

/datum/spawnpoint/gateway/New()
	..()
	GLOB.turfs = GLOB.latejoin_gateway

/datum/spawnpoint/cryo
	display_name = "Cryogenic Storage"
	msg = "has completed cryogenic revival"
	disallow_job = list("Cyborg")

/datum/spawnpoint/cryo/New()
	..()
	GLOB.turfs = GLOB.latejoin_cryo

/datum/spawnpoint/cyborg
	display_name = "Cyborg Storage"
	msg = "has been activated from storage"
	restrict_job = list("Cyborg")

/datum/spawnpoint/cyborg/New()
	..()
	GLOB.turfs = GLOB.latejoin_cyborg

/datum/spawnpoint/default
	display_name = DEFAULT_SPAWNPOINT_ID
	msg = "has arrived on the station"
	always_visible = TRUE
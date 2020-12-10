/datum/event/gravity
	announceWhen = 5

/datum/event/gravity/setup()
	endWhen = rand(15, 60)

/datum/event/gravity/announce()
	GLOB.command_announcement.Announce("Feedback surge detected in mass-distributions systems. Artificial gravity has been disabled whilst the system reinitializes.", "Gravity Failure")

/datum/event/gravity/start()
	GLOB.gravity_is_on = 0
	for(var/area/A in world)
		if(A.z in GLOB.using_map.station_levels)
			A.gravitychange(GLOB.gravity_is_on)

/datum/event/gravity/end()
	if(!GLOB.gravity_is_on)
		GLOB.gravity_is_on = 1

		for(var/area/A in world)
			if(A.z in GLOB.using_map.station_levels)
				A.gravitychange(GLOB.gravity_is_on)

		GLOB.command_announcement.Announce("Gravity generators are again functioning within normal parameters. Sorry for any inconvenience.", "Gravity Restored")

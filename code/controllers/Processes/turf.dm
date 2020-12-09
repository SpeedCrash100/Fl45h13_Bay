GLOBAL_LIST_EMPTY_TYPED(processing_turfs, /turf)

/datum/controller/process/turf/setup()
	name = "turf"
	schedule_interval = 20 // every 2 seconds

/datum/controller/process/turf/doWork()
	for(last_object in GLOB.processing_turfs)
		var/turf/T = last_object
		if(T.process() == PROCESS_KILL)
			GLOB.processing_turfs.Remove(T)
		SCHECK

/datum/controller/process/turf/statProcess()
	..()
	stat(null, "[GLOB.processing_turfs.len] turf\s")

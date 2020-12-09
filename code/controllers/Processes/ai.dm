GLOBAL_LIST_EMPTY_TYPED(list_of_ais, /datum)

/datum/controller/process/ai/setup()
	name = "ai"
	schedule_interval = 2 SECONDS
	start_delay = 17

/datum/controller/process/ai/doWork()
	for(last_object in GLOB.list_of_ais)
		var/datum/ai/AI = last_object
		if(!QDELETED(AI) && istype(AI))
			try
				if(AI.process() == PROCESS_KILL)
					GLOB.list_of_ais -= AI
			catch(var/exception/e)
				catchException(e, AI)
			SCHECK
		else
			catchBadType(AI)
			GLOB.list_of_ais -= AI

/datum/controller/process/ai/statProcess()
	..()
	stat(null, "[GLOB.list_of_ais.len] AI\s")

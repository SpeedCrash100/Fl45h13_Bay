/datum/controller/process/Shuttle/setup()
	name = "shuttle controller"
	schedule_interval = 20 // every 2 seconds

	if(!GLOB.shuttle_controller)
		GLOB.shuttle_controller = new

/datum/controller/process/Shuttle/doWork()
	GLOB.shuttle_controller.process()

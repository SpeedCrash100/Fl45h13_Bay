/datum/controller/process/evac/setup()
	name = "evacuation"
	schedule_interval = 20 // every 2 seconds

	if(!GLOB.evacuation_controller)
		GLOB.evacuation_controller = new GLOB.using_map.evac_controller_type ()
		GLOB.evacuation_controller.set_up()

/datum/controller/process/evac/doWork()
	GLOB.evacuation_controller.process()

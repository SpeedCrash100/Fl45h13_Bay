/datum/controller/process/air/setup()
	name = "air"
	schedule_interval = 20 // every 2 seconds
	start_delay = 4

	if(!GLOB.air_master)
		GLOB.air_master = new
		GLOB.air_master.Setup()

/datum/controller/process/air/doWork()
	if(!GLOB.air_processing_killed)
		if(!GLOB.air_master.Tick()) //Runtimed.
			GLOB.air_master.failed_ticks++

			if(GLOB.air_master.failed_ticks > 5)
				to_world("<SPAN CLASS='danger'>RUNTIME'S IN ATMOS TICKER.  Killing air simulation!</SPAN>")

				log_error("### ZAS SHUTDOWN")

				message_admins("ZASALERT: Shutting down! status: [GLOB.air_master.tick_progress]")
				log_admin("ZASALERT: Shutting down! status: [GLOB.air_master.tick_progress]")

				GLOB.air_processing_killed = TRUE
				GLOB.air_master.failed_ticks = 0

//simplified MC that is designed to fail when procs 'break'. When it fails it's just replaced with a new one.
//It ensures master_controller.process() is never doubled up by killing the MC (hence terminating any of its sleeping procs)
//WIP, needs lots of work still

GLOBAL_DATUM(master_controller, /datum/controller/game_controller)

GLOBAL_VAR_INIT(controller_iteration, 0) 
GLOBAL_VAR_INIT(last_tick_duration, 0) 

GLOBAL_VAR_INIT(air_processing_killed, 0) 
GLOBAL_VAR_INIT(pipe_processing_killed, 0) 

GLOBAL_VAR_INIT(initialization_stage, 0) 

datum/controller/game_controller
	var/list/shuttle_list	                    // For debugging and VV
	var/init_immediately = FALSE

datum/controller/game_controller/New()
	//There can be only one master_controller. Out with the old and in with the new.
	if(GLOB.master_controller != src)
		log_debug("Rebuilding Master Controller")
		if(istype(GLOB.master_controller))
			qdel(GLOB.master_controller)
		GLOB.master_controller = src

	if(!GLOB.job_master)
		GLOB.job_master = new /datum/controller/occupations()
		GLOB.job_master.SetupOccupations(setup_titles=1)
		GLOB.job_master.LoadJobs("config/jobs.txt")
		admin_notice("<span class='danger'>Job setup complete</span>", R_DEBUG)

datum/controller/game_controller/proc/setup()
	spawn(20)
		createRandomZlevel()

	setup_objects()
	setupgenetics()
	SetupXenoarch()

	GLOB.transfer_controller = new

	report_progress("Initializations complete")
	GLOB.initialization_stage |= INITIALIZATION_COMPLETE

#ifdef UNIT_TEST
#define CHECK_SLEEP_MASTER // For unit tests we don't care about a smooth lobby screen experience. We care about speed.
#else
#define CHECK_SLEEP_MASTER if(!(GLOB.initialization_stage & INITIALIZATION_NOW) && ++initialized_objects > 500) { initialized_objects=0;sleep(world.tick_lag); }
#endif

datum/controller/game_controller/proc/setup_objects()
#ifndef UNIT_TEST
	var/initialized_objects = 0
#endif

	// Do these first since character setup will rely on them

	//Set up spawn points.
	populate_spawn_points()

	GLOB.initialization_stage |= INITIALIZATION_HAS_BEGUN

	report_progress("Initializing turbolifts")
	for(var/thing in GLOB.turbolifts)
		var/obj/turbolift_map_holder/lift = thing
		if(!QDELETED(lift))
			lift.initialize()
			CHECK_SLEEP_MASTER

	report_progress("Initializing objects")
	for(var/atom/movable/object)
		if(!QDELETED(object))
			object.initialize()
			CHECK_SLEEP_MASTER

	report_progress("Initializing areas")
	for(var/area/area)
		area.initialize()
		CHECK_SLEEP_MASTER

	if(GLOB.using_map.use_overmap)
		report_progress("Initializing overmap events")
		overmap_event_handler.create_events(GLOB.using_map.overmap_z, GLOB.using_map.overmap_size, GLOB.using_map.overmap_event_areas)
		CHECK_SLEEP_MASTER

	report_progress("Initializing pipe networks")
	for(var/obj/machinery/atmospherics/machine in GLOB.machines)
		machine.build_network()
		CHECK_SLEEP_MASTER

	report_progress("Initializing atmos machinery")
	for(var/obj/machinery/atmospherics/unary/U in GLOB.machines)
		if(istype(U, /obj/machinery/atmospherics/unary/vent_pump))
			var/obj/machinery/atmospherics/unary/vent_pump/T = U
			T.broadcast_status()
		else if(istype(U, /obj/machinery/atmospherics/unary/vent_scrubber))
			var/obj/machinery/atmospherics/unary/vent_scrubber/T = U
			T.broadcast_status()
		CHECK_SLEEP_MASTER

#undef CHECK_SLEEP_MASTER

datum/controller/game_controller/proc/report_progress(var/progress_message)
	admin_notice("<span class='danger'>[progress_message]</span>", R_DEBUG)
#ifdef UNIT_TEST
	to_world_log("\[[time2text(world.realtime, "hh:mm:ss")]\] [progress_message]")
#endif

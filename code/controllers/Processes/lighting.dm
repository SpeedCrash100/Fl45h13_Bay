GLOBAL_VAR_INIT(lighting_overlays_initialised, FALSE)

GLOBAL_LIST_EMPTY(lighting_update_lights)    // List of lighting sources  queued for update.
GLOBAL_LIST_EMPTY(lighting_update_corners)    // List of lighting corners  queued for update.
GLOBAL_LIST_EMPTY(lighting_update_overlays)    // List of lighting overlays queued for update.

GLOBAL_LIST_EMPTY(lighting_update_lights_old)    // List of lighting sources  currently being updated.
GLOBAL_LIST_EMPTY(lighting_update_corners_old)    // List of lighting corners  currently being updated.
GLOBAL_LIST_EMPTY(lighting_update_overlays_old)    // List of lighting overlays currently being updated.


/datum/controller/process/lighting
	// Queues of update counts, waiting to be rolled into stats lists
	var/list/stats_queues = list(
		"Source" = list(), "Corner" = list(), "Overlay" = list())
	// Stats lists
	var/list/stats_lists = list(
		"Source" = list(), "Corner" = list(), "Overlay" = list())
	var/update_stats_every = (1 SECONDS)
	var/next_stats_update = 0
	var/stat_updates_to_keep = 5

/datum/controller/process/lighting/setup()
	name = "lighting"

	schedule_interval = 0 // run as fast as you possibly can
	sleep_interval = 10
	create_all_lighting_overlays()
	GLOB.lighting_overlays_initialised = TRUE

	// Pre-process lighting once before the round starts. Wait 30 seconds so the away mission has time to load.
	spawn(300)
		doWork(1)

/datum/controller/process/lighting/doWork(roundstart)

	GLOB.lighting_update_lights_old = GLOB.lighting_update_lights //We use a different list so any additions to the update lists during a delay from scheck() don't cause things to be cut from the list without being updated.
	GLOB.lighting_update_lights = list()
	for(var/datum/light_source/L in GLOB.lighting_update_lights_old)

		if(L.check() || L.destroyed || L.force_update)
			L.remove_lum()
			if(!L.destroyed)
				L.apply_lum()

		else if(L.vis_update)	//We smartly update only tiles that became (in) visible to use.
			L.smart_vis_update()

		L.vis_update   = FALSE
		L.force_update = FALSE
		L.needs_update = FALSE

		SCHECK

	GLOB.lighting_update_corners_old = GLOB.lighting_update_corners //Same as above.
	GLOB.lighting_update_corners = list()
	for(var/A in GLOB.lighting_update_corners_old)
		var/datum/lighting_corner/C = A

		C.update_overlays()

		C.needs_update = FALSE

		SCHECK

	GLOB.lighting_update_overlays_old = GLOB.lighting_update_overlays //Same as above.
	GLOB.lighting_update_overlays = list()

	for(var/A in GLOB.lighting_update_overlays_old)
		var/atom/movable/lighting_overlay/O = A
		O.update_overlay()
		O.needs_update = 0
		SCHECK

	stats_queues["Source"] += GLOB.lighting_update_lights_old.len
	stats_queues["Corner"] += GLOB.lighting_update_corners_old.len
	stats_queues["Overlay"] += GLOB.lighting_update_overlays_old.len

	if(next_stats_update <= world.time)
		next_stats_update = world.time + update_stats_every
		for(var/stat_name in stats_queues)
			var/stat_sum = 0
			var/list/stats_queue = stats_queues[stat_name]
			for(var/count in stats_queue)
				stat_sum += count
			stats_queue.Cut()

			var/list/stats_list = stats_lists[stat_name]
			stats_list.Insert(1, stat_sum)
			if(stats_list.len > stat_updates_to_keep)
				stats_list.Cut(stats_list.len)

/datum/controller/process/lighting/statProcess()
	..()
	stat(null, "[GLOB.total_lighting_sources] sources, [GLOB.total_lighting_corners] corners, [GLOB.total_lighting_overlays] overlays")
	for(var/stat_type in stats_lists)
		stat(null, "[stat_type] updates: [jointext(stats_lists[stat_type], " | ")]")

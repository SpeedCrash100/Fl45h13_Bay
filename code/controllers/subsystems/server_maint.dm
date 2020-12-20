
SUBSYSTEM_DEF(server_maint)
	name = "Server Tasks"
	wait = 6
	flags = SS_NO_FIRE
	priority = FIRE_PRIORITY_SERVER_MAINT
	init_order = INIT_ORDER_SERVER_MAINT
	runlevels = RUNLEVEL_LOBBY | RUNLEVELS_DEFAULT
	var/list/currentrun
	var/cleanup_ticker = 0

/datum/controller/subsystem/server_maint/PreInit()
	. = ..()
	world.visibility = FALSE

/datum/controller/subsystem/server_maint/Initialize(start_timeofday)
	. = ..()
	world.set_hub_visibility(GLOB.config?.hub)

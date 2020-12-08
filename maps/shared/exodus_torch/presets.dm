GLOBAL_VAR_CONST(NETWORK_COMMAND, "Command")
GLOBAL_VAR_CONST(NETWORK_ENGINE, "Engine")
GLOBAL_VAR_CONST(NETWORK_ENGINEERING_OUTPOST, "Engineering Outpost")

/datum/map/proc/get_shared_network_access(var/network)
	switch(network)
		if(GLOB.NETWORK_COMMAND)
			return GLOB.access_heads
		if(GLOB.NETWORK_ENGINE, GLOB.NETWORK_ENGINEERING_OUTPOST)
			return GLOB.access_engine

//
// Cameras
//

// Networks
/obj/machinery/camera/network/command
	network = list(GLOB.NETWORK_COMMAND)

/obj/machinery/camera/network/crescent
	network = list(NETWORK_CRESCENT)

/obj/machinery/camera/network/engine
	network = list(GLOB.NETWORK_ENGINE)

/obj/machinery/camera/network/engineering_outpost
	network = list(GLOB.NETWORK_ENGINEERING_OUTPOST)

// Motion
/obj/machinery/camera/motion/engineering_outpost
	network = list(GLOB.NETWORK_ENGINEERING_OUTPOST)

// All Upgrades
/obj/machinery/camera/all/command
	network = list(GLOB.NETWORK_COMMAND)

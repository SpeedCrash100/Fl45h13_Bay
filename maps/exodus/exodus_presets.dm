GLOBAL_VAR_CONST(NETWORK_CIVILIAN_EAST, "Civilian East")
GLOBAL_VAR_CONST(NETWORK_CIVILIAN_WEST, "Civilian West")
GLOBAL_VAR_CONST(NETWORK_MAINTENANCE, "Maintenance Deck")
GLOBAL_VAR_CONST(NETWORK_PRISON, "Prison")
GLOBAL_VAR_CONST(NETWORK_RESEARCH_OUTPOST, "Research Outpost")
GLOBAL_VAR_CONST(NETWORK_TELECOM, "Tcomsat")

/datum/map/exodus/get_network_access(var/network)
	switch(network)
		if(GLOB.NETWORK_CIVILIAN_WEST)
			return GLOB.access_mailsorting
		if(GLOB.NETWORK_RESEARCH_OUTPOST)
			return GLOB.access_research
		if(GLOB.NETWORK_TELECOM)
			return GLOB.access_heads
	return get_shared_network_access(network) || ..()

/datum/map/exodus
	station_networks = list(
		GLOB.NETWORK_CIVILIAN_EAST,
		GLOB.NETWORK_CIVILIAN_WEST,
		GLOB.NETWORK_COMMAND,
		GLOB.NETWORK_ENGINE,
		NETWORK_ENGINEERING,
		GLOB.NETWORK_ENGINEERING_OUTPOST,
		NETWORK_EXODUS,
		GLOB.NETWORK_MAINTENANCE,
		NETWORK_MEDICAL,
		NETWORK_MINE,
		NETWORK_RESEARCH,
		GLOB.NETWORK_RESEARCH_OUTPOST,
		NETWORK_ROBOTS,
		GLOB.NETWORK_PRISON,
		NETWORK_SECURITY,
		NETWORK_ALARM_ATMOS,
		NETWORK_ALARM_CAMERA,
		NETWORK_ALARM_FIRE,
		NETWORK_ALARM_MOTION,
		NETWORK_ALARM_POWER,
		NETWORK_THUNDER,
		GLOB.NETWORK_TELECOM
	)

//
// Cameras
//

// Networks
/obj/machinery/camera/network/civilian_east
	network = list(GLOB.NETWORK_CIVILIAN_EAST)

/obj/machinery/camera/network/civilian_west
	network = list(GLOB.NETWORK_CIVILIAN_WEST)

/obj/machinery/camera/network/command
	network = list(GLOB.NETWORK_COMMAND)

/obj/machinery/camera/network/exodus
	network = list(NETWORK_EXODUS)

/obj/machinery/camera/network/maintenance
	network = list(GLOB.NETWORK_MAINTENANCE)

/obj/machinery/camera/network/prison
	network = list(GLOB.NETWORK_PRISON)

/obj/machinery/camera/network/research
	network = list(NETWORK_RESEARCH)

/obj/machinery/camera/network/research_outpost
	network = list(GLOB.NETWORK_RESEARCH_OUTPOST)

/obj/machinery/camera/network/telecom
	network = list(GLOB.NETWORK_TELECOM)

// Motion
/obj/machinery/camera/motion/command
	network = list(GLOB.NETWORK_COMMAND)

// X-ray
/obj/machinery/camera/xray/medbay
	network = list(NETWORK_MEDICAL)

/obj/machinery/camera/xray/research
	network = list(NETWORK_RESEARCH)

/obj/machinery/camera/xray/security
	network = list(NETWORK_SECURITY)

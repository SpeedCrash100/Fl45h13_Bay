//Engine component object

GLOBAL_LIST_EMPTY(ship_engines)
/datum/ship_engine
	var/name = "ship engine"
	var/obj/machinery/holder	//actual engine object

/datum/ship_engine/New(var/obj/machinery/_holder)
	..()
	holder = _holder
	GLOB.ship_engines += src
	var/obj/effect/overmap/ship/S = GLOB.map_sectors["[holder.z]"]
	if(istype(S))
		S.engines |= src

/datum/ship_engine/proc/can_burn()
	return 0

//Tries to fire the engine. Returns thrust
/datum/ship_engine/proc/burn()
	return 0

//Returns status string for this engine
/datum/ship_engine/proc/get_status()
	return "All systems nominal"

/datum/ship_engine/proc/get_thrust()
	return 1

//Sets thrust limiter, a number between 0 and 1
/datum/ship_engine/proc/set_thrust_limit(var/new_limit)
	return 1

/datum/ship_engine/proc/get_thrust_limit()
	return 1

/datum/ship_engine/proc/is_on()
	return 1

/datum/ship_engine/proc/toggle()
	return 1

/datum/ship_engine/Destroy()
	..()
	GLOB.ship_engines -= src
	var/obj/effect/overmap/ship/S = GLOB.map_sectors["[holder.z]"]
	if(istype(S))
		S.engines -= src
	holder = null
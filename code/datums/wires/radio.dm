/datum/wires/radio
	holder_type = /obj/item/device/radio
	wire_count = 3

GLOBAL_VAR_CONST(WIRE_SIGNAL, 1)
GLOBAL_VAR_CONST(WIRE_RECEIVE, 2)
GLOBAL_VAR_CONST(WIRE_TRANSMIT, 4)

/datum/wires/radio/CanUse(var/mob/living/L)
	var/obj/item/device/radio/R = holder
	if(R.b_stat)
		return 1
	return 0

/datum/wires/radio/UpdatePulsed(var/index)
	var/obj/item/device/radio/R = holder
	switch(index)
		if(GLOB.WIRE_SIGNAL)
			R.listening = !R.listening && !IsIndexCut(GLOB.WIRE_RECEIVE)
			R.broadcasting = R.listening && !IsIndexCut(GLOB.WIRE_TRANSMIT)

		if(GLOB.WIRE_RECEIVE)
			R.listening = !R.listening && !IsIndexCut(GLOB.WIRE_SIGNAL)

		if(GLOB.WIRE_TRANSMIT)
			R.broadcasting = !R.broadcasting && !IsIndexCut(GLOB.WIRE_SIGNAL)
	GLOB.nanomanager.update_uis(holder)

/datum/wires/radio/UpdateCut(var/index, var/mended)
	var/obj/item/device/radio/R = holder
	switch(index)
		if(GLOB.WIRE_SIGNAL)
			R.listening = mended && !IsIndexCut(GLOB.WIRE_RECEIVE)
			R.broadcasting = mended && !IsIndexCut(GLOB.WIRE_TRANSMIT)

		if(GLOB.WIRE_RECEIVE)
			R.listening = mended && !IsIndexCut(GLOB.WIRE_SIGNAL)

		if(GLOB.WIRE_TRANSMIT)
			R.broadcasting = mended && !IsIndexCut(GLOB.WIRE_SIGNAL)
	GLOB.nanomanager.update_uis(holder)

GLOBAL_VAR_INIT(security_level, 0) //0 = code green
//1 = code blue
//2 = code red
//3 = code delta

//config.alert_desc_blue_downto
GLOBAL_DATUM_INIT(security_announcement_up, /datum/announcement/priority/security, new(do_log = 0, do_newscast = 1, new_sound = sound('sound/misc/notice1.ogg')))
GLOBAL_DATUM_INIT(security_announcement_down, /datum/announcement/priority/security, new(do_log = 0, do_newscast = 1))

/proc/set_security_level(var/level)
	switch(level)
		if("green")
			level = SEC_LEVEL_GREEN
		if("blue")
			level = SEC_LEVEL_BLUE
		if("red")
			level = SEC_LEVEL_RED
		if("delta")
			level = SEC_LEVEL_DELTA

	//Will not be announced if you try to set to the same level as it already is
	if(level >= SEC_LEVEL_GREEN && level <= SEC_LEVEL_DELTA && level != GLOB.security_level)
		switch(level)
			if(SEC_LEVEL_GREEN)
				GLOB.security_announcement_down.Announce("[GLOB.config.alert_desc_green]", "Attention! Security level lowered to green")
				GLOB.security_level = SEC_LEVEL_GREEN
				post_status("alert", "greenalert")
			if(SEC_LEVEL_BLUE)
				if(GLOB.security_level < SEC_LEVEL_BLUE)
					GLOB.security_announcement_up.Announce("[GLOB.config.alert_desc_blue_upto]", "Attention! Security level elevated to blue")
				else
					GLOB.security_announcement_down.Announce("[GLOB.config.alert_desc_blue_downto]", "Attention! Security level lowered to blue")
				GLOB.security_level = SEC_LEVEL_BLUE
				post_status("alert", "bluealert")
			if(SEC_LEVEL_RED)
				if(GLOB.security_level < SEC_LEVEL_RED)
					GLOB.security_announcement_up.Announce("[GLOB.config.alert_desc_red_upto]", "Attention! Code red!")
				else
					GLOB.security_announcement_down.Announce("[GLOB.config.alert_desc_red_downto]", "Attention! Code red!")
				GLOB.security_level = SEC_LEVEL_RED
				post_status("alert", "redalert")
			if(SEC_LEVEL_DELTA)
				GLOB.security_announcement_up.Announce("[GLOB.config.alert_desc_delta]", "Attention! Delta security level reached!", new_sound = 'sound/effects/siren.ogg')
				GLOB.security_level = SEC_LEVEL_DELTA
				post_status("alert", "deltaalert")

		var/newlevel = get_security_level()
		for(var/obj/machinery/firealarm/FA in GLOB.machines)
			if(FA.z in GLOB.using_map.contact_levels)
				FA.set_security_level(newlevel)


/proc/get_security_level()
	switch(GLOB.security_level)
		if(SEC_LEVEL_GREEN)
			return "green"
		if(SEC_LEVEL_BLUE)
			return "blue"
		if(SEC_LEVEL_RED)
			return "red"
		if(SEC_LEVEL_DELTA)
			return "delta"

/proc/num2seclevel(var/num)
	switch(num)
		if(SEC_LEVEL_GREEN)
			return "green"
		if(SEC_LEVEL_BLUE)
			return "blue"
		if(SEC_LEVEL_RED)
			return "red"
		if(SEC_LEVEL_DELTA)
			return "delta"

/proc/seclevel2num(var/seclevel)
	switch( lowertext(seclevel) )
		if("green")
			return SEC_LEVEL_GREEN
		if("blue")
			return SEC_LEVEL_BLUE
		if("red")
			return SEC_LEVEL_RED
		if("delta")
			return SEC_LEVEL_DELTA


/*DEBUG
/mob/verb/set_thing0()
	set_security_level(0)
/mob/verb/set_thing1()
	set_security_level(1)
/mob/verb/set_thing2()
	set_security_level(2)
/mob/verb/set_thing3()
	set_security_level(3)
*/
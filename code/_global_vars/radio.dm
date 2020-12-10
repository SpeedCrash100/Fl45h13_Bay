GLOBAL_LIST_INIT(default_internal_channels,
	list(
		num2text(GLOB.PUB_FREQ) = list(),
		num2text(GLOB.AI_FREQ)  = list(GLOB.access_synth),
		num2text(GLOB.ENT_FREQ) = list(),
		num2text(GLOB.ERT_FREQ) = list(GLOB.access_cent_specops),
		num2text(GLOB.COMM_FREQ)= list(GLOB.access_heads),
		num2text(GLOB.ENG_FREQ) = list(GLOB.access_engine_equip, GLOB.access_atmospherics),
		num2text(GLOB.MED_FREQ) = list(GLOB.access_medical_equip),
		num2text(GLOB.MED_I_FREQ)=list(GLOB.access_medical_equip),
		num2text(GLOB.SEC_FREQ) = list(GLOB.access_security),
		num2text(GLOB.SEC_I_FREQ)=list(GLOB.access_security),
		num2text(GLOB.SCI_FREQ) = list(GLOB.access_tox,GLOB.access_robotics,GLOB.access_xenobiology),
		num2text(GLOB.SUP_FREQ) = list(GLOB.access_cargo),
		num2text(GLOB.SRV_FREQ) = list(GLOB.access_janitor, GLOB.access_hydroponics)
	))

GLOBAL_DATUM_INIT(priority_announcement, /datum/announcement/priority, new(do_log = 0))
GLOBAL_DATUM_INIT(command_announcement, /datum/announcement/priority/command, new(do_log = 0, do_newscast = 1))
GLOBAL_DATUM_INIT(minor_announcement, /datum/announcement/minor, new(new_sound = 'sound/AI/commandreport.ogg',))

//TODO: rewrite and standardise all controller datums to the datum/controller type
//TODO: allow all controllers to be deleted for clean restarts (see WIP master controller stuff) - MC done - lighting done

/client/proc/debug_antagonist_template(antag_type as null|anything in all_antag_types())
	set category = "Debug"
	set name = "Debug Antagonist"
	set desc = "Debug an antagonist template."

	if (!antag_type)
		return

	var/datum/antagonist/antag = all_antag_types()[antag_type]
	if(antag)
		usr.client.debug_variables(antag)
		message_admins("Admin [key_name_admin(usr)] is debugging the [antag.role_text] template.")

/client/proc/debug_controller(controller as null|anything in list("Master","Ticker","Ticker Process","Air","Jobs","Sun","Radio","Supply","Shuttles","Evacuation","Configuration","pAI", "Cameras", "Transfer Controller", "Gas Data","Event","Plants","Alarm","Nano","Chemistry","Wireless","Observation","Alt Appearance Manager","Datacore","Military Branches"))
	set category = "Debug"
	set name = "Debug Controller"
	set desc = "Debug the various periodic loop controllers for the game (be careful!)"

	if(!holder || !controller)
		return

	switch(controller)
		if("Master")
			debug_variables(GLOB.master_controller)
			feedback_add_details("admin_verb","DMC")
		if("Ticker")
			debug_variables(GLOB.ticker)
			feedback_add_details("admin_verb","DTicker")
		if("Air")
			debug_variables(GLOB.air_master)
			feedback_add_details("admin_verb","DAir")
		if("Jobs")
			debug_variables(GLOB.job_master)
			feedback_add_details("admin_verb","DJobs")
		if("Sun")
			debug_variables(GLOB.sun)
			feedback_add_details("admin_verb","DSun")
		if("Radio")
			debug_variables(GLOB.radio_controller)
			feedback_add_details("admin_verb","DRadio")
		if("Supply")
			debug_variables(GLOB.supply_controller)
			feedback_add_details("admin_verb","DSupply")
		if("Shuttles")
			debug_variables(GLOB.shuttle_controller)
			feedback_add_details("admin_verb","DShuttles")
		if("Evacuation")
			debug_variables(GLOB.evacuation_controller)
			feedback_add_details("admin_verb","DEmergency")
		if("Configuration")
			debug_variables(GLOB.config)
			feedback_add_details("admin_verb","DConf")
		if("pAI")
			debug_variables(GLOB.paiController)
			feedback_add_details("admin_verb","DpAI")
		if("Cameras")
			debug_variables(GLOB.cameranet)
			feedback_add_details("admin_verb","DCameras")
		if("Transfer Controller")
			debug_variables(GLOB.transfer_controller)
			feedback_add_details("admin_verb","DAutovoter")
		if("Gas Data")
			debug_variables(GLOB.gas_data)
			feedback_add_details("admin_verb","DGasdata")
		if("Event")
			debug_variables(GLOB.event_manager)
			feedback_add_details("admin_verb", "DEvent")
		if("Plants")
			debug_variables(GLOB.plant_controller)
			feedback_add_details("admin_verb", "DPlants")
		if("Nano")
			debug_variables(GLOB.nanomanager)
			feedback_add_details("admin_verb", "DNano")
		if("Observation")
			debug_variables(GLOB.all_observable_events)
			feedback_add_details("admin_verb", "DObservation")
		if("Alt Appearance Manager")
			debug_variables(GLOB.all_observable_events)
			feedback_add_details("admin_verb", "DAltAppearanceManager")
		if("Datacore")
			debug_variables(GLOB.data_core)
			feedback_add_details("admin_verb", "DDatacore")
		if("Military Branches")
			debug_variables(GLOB.mil_branches)
			feedback_add_details("admin_verb", "DMilBranches")
	message_admins("Admin [key_name_admin(usr)] is debugging the [controller] controller.")
	return

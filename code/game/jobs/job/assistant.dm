/datum/job/assistant
	title = "Assistant"
	department = "Civilian"
	department_flag = GLOB.CIV
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	supervisors = "absolutely everyone"
	selection_color = "#515151"
	economic_modifier = 1
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	alt_titles = list("Technical Assistant","Medical Intern","Research Assistant","Visitor")
	outfit_type = /decl/hierarchy/outfit/job/assistant

/datum/job/assistant/get_access()
	if(GLOB.config.assistant_maint)
		return list(GLOB.access_maint_tunnels)
	else
		return list()

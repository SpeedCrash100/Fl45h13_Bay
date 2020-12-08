/datum/job/chief_engineer
	title = "Chief Engineer"
	head_position = 1
	department = "Engineering"
	department_flag = GLOB.ENG|GLOB.COM
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#7f6e2c"
	req_admin_notify = 1
	economic_modifier = 10

	ideal_character_age = 50


	access = list(GLOB.access_engine, GLOB.access_engine_equip, GLOB.access_tech_storage, GLOB.access_maint_tunnels,
						GLOB.access_teleporter, GLOB.access_external_airlocks, GLOB.access_atmospherics, GLOB.access_emergency_storage, GLOB.access_eva,
						GLOB.access_heads, GLOB.access_construction, GLOB.access_sec_doors,
						GLOB.access_ce, GLOB.access_RC_announce, GLOB.access_keycard_auth, GLOB.access_tcomsat, GLOB.access_ai_upload)
	minimal_access = list(GLOB.access_engine, GLOB.access_engine_equip, GLOB.access_tech_storage, GLOB.access_maint_tunnels,
						GLOB.access_teleporter, GLOB.access_external_airlocks, GLOB.access_atmospherics, GLOB.access_emergency_storage, GLOB.access_eva,
						GLOB.access_heads, GLOB.access_construction, GLOB.access_sec_doors,
						GLOB.access_ce, GLOB.access_RC_announce, GLOB.access_keycard_auth, GLOB.access_tcomsat, GLOB.access_ai_upload)
	minimal_player_age = 14
	outfit_type = /decl/hierarchy/outfit/job/engineering/chief_engineer
	announced = 1

/datum/job/engineer
	title = "Engineer"
	department = "Engineering"
	department_flag = GLOB.ENG
	faction = "Station"
	total_positions = 8
	spawn_positions = 7
	supervisors = "the chief engineer"
	selection_color = "#5b4d20"
	economic_modifier = 5
	minimal_player_age = 7
	access = list(GLOB.access_eva, GLOB.access_engine, GLOB.access_engine_equip, GLOB.access_tech_storage, GLOB.access_maint_tunnels, GLOB.access_external_airlocks, GLOB.access_construction, GLOB.access_atmospherics, GLOB.access_emergency_storage)
	minimal_access = list(GLOB.access_eva, GLOB.access_engine, GLOB.access_engine_equip, GLOB.access_tech_storage, GLOB.access_maint_tunnels, GLOB.access_external_airlocks, GLOB.access_construction, GLOB.access_atmospherics, GLOB.access_emergency_storage)
	alt_titles = list("Maintenance Technician","Engine Technician","Electrician",
		"Atmospheric Technician" = /decl/hierarchy/outfit/job/engineering/atmos)
	outfit_type = /decl/hierarchy/outfit/job/engineering/engineer

/datum/job/atmos
	title = "Atmospheric Technician"
	department = "Engineering"
	department_flag = GLOB.ENG
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	supervisors = "the chief engineer"
	selection_color = "#5b4d20"
	economic_modifier = 5
	minimal_player_age = 7
	access = list(GLOB.access_eva, GLOB.access_engine, GLOB.access_engine_equip, GLOB.access_tech_storage, GLOB.access_maint_tunnels, GLOB.access_external_airlocks, GLOB.access_construction, GLOB.access_atmospherics, GLOB.access_emergency_storage)
	minimal_access = list(GLOB.access_eva, GLOB.access_engine, GLOB.access_engine_equip, GLOB.access_tech_storage, GLOB.access_maint_tunnels, GLOB.access_external_airlocks, GLOB.access_construction, GLOB.access_atmospherics, GLOB.access_emergency_storage)
	outfit_type = /decl/hierarchy/outfit/job/engineering/atmos

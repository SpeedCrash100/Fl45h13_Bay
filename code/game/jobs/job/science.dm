/datum/job/rd
	title = "Research Director"
	head_position = 1
	department = "Science"
	department_flag = GLOB.COM|GLOB.SCI
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#ad6bad"
	req_admin_notify = 1
	economic_modifier = 15
	access = list(GLOB.access_rd, GLOB.access_heads, GLOB.access_tox, GLOB.access_genetics, GLOB.access_morgue,
						GLOB.access_tox_storage, GLOB.access_teleporter, GLOB.access_sec_doors,
						GLOB.access_research, GLOB.access_robotics, GLOB.access_xenobiology, GLOB.access_ai_upload, GLOB.access_tech_storage,
						GLOB.access_RC_announce, GLOB.access_keycard_auth, GLOB.access_tcomsat, GLOB.access_gateway, GLOB.access_xenoarch, GLOB.access_network)
	minimal_access = list(GLOB.access_rd, GLOB.access_heads, GLOB.access_tox, GLOB.access_genetics, GLOB.access_morgue,
						GLOB.access_tox_storage, GLOB.access_teleporter, GLOB.access_sec_doors,
						GLOB.access_research, GLOB.access_robotics, GLOB.access_xenobiology, GLOB.access_ai_upload, GLOB.access_tech_storage,
						GLOB.access_RC_announce, GLOB.access_keycard_auth, GLOB.access_tcomsat, GLOB.access_gateway, GLOB.access_xenoarch, GLOB.access_network)
	minimal_player_age = 14
	ideal_character_age = 50
	outfit_type = /decl/hierarchy/outfit/job/science/rd
	announced = 1

/datum/job/scientist
	title = "Scientist"
	department = "Science"
	department_flag = GLOB.SCI
	faction = "Station"
	total_positions = 5
	spawn_positions = 3
	supervisors = "the research director"
	selection_color = "#633d63"
	economic_modifier = 7
	access = list(GLOB.access_robotics, GLOB.access_tox, GLOB.access_tox_storage, GLOB.access_research, GLOB.access_xenobiology, GLOB.access_xenoarch)
	minimal_access = list(GLOB.access_tox, GLOB.access_tox_storage, GLOB.access_research, GLOB.access_xenoarch)
	alt_titles = list("Xenoarcheologist", "Anomalist", "Phoron Researcher")
	minimal_player_age = 7
	outfit_type = /decl/hierarchy/outfit/job/science/scientist

/datum/job/xenobiologist
	title = "Xenobiologist"
	department = "Science"
	department_flag = GLOB.SCI
	faction = "Station"
	total_positions = 3
	spawn_positions = 2
	supervisors = "the research director"
	selection_color = "#633d63"
	economic_modifier = 7
	access = list(GLOB.access_robotics, GLOB.access_tox, GLOB.access_tox_storage, GLOB.access_research, GLOB.access_xenobiology, GLOB.access_hydroponics)
	minimal_access = list(GLOB.access_research, GLOB.access_xenobiology, GLOB.access_hydroponics)
	alt_titles = list("Xenobotanist")
	minimal_player_age = 7
	outfit_type = /decl/hierarchy/outfit/job/science/xenobiologist

/datum/job/roboticist
	title = "Roboticist"
	department = "Science"
	department_flag = GLOB.SCI
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "research director"
	selection_color = "#633d63"
	economic_modifier = 5
	access = list(GLOB.access_robotics, GLOB.access_tox, GLOB.access_tox_storage, GLOB.access_tech_storage, GLOB.access_morgue, GLOB.access_research) //As a job that handles so many corpses, it makes sense for them to have morgue access.
	minimal_access = list(GLOB.access_robotics, GLOB.access_tech_storage, GLOB.access_morgue, GLOB.access_research) //As a job that handles so many corpses, it makes sense for them to have morgue access.
	alt_titles = list("Biomechanical Engineer","Mechatronic Engineer")
	minimal_player_age = 3
	outfit_type = /decl/hierarchy/outfit/job/science/roboticist

//Food
/datum/job/bartender
	title = "Bartender"
	department = "Service"
	department_flag = GLOB.SRV
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	access = list(GLOB.access_hydroponics, GLOB.access_bar, GLOB.access_kitchen)
	minimal_access = list(GLOB.access_bar)
	outfit_type = /decl/hierarchy/outfit/job/service/bartender

/datum/job/chef
	title = "Chef"
	department = "Service"
	department_flag = GLOB.SRV
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the head of personnel"
	selection_color = "#515151"
	access = list(GLOB.access_hydroponics, GLOB.access_bar, GLOB.access_kitchen)
	minimal_access = list(GLOB.access_kitchen)
	alt_titles = list("Cook")
	outfit_type = /decl/hierarchy/outfit/job/service/chef

/datum/job/hydro
	title = "Gardener"
	department = "Service"
	department_flag = GLOB.SRV
	faction = "Station"
	total_positions = 2
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	access = list(GLOB.access_hydroponics, GLOB.access_bar, GLOB.access_kitchen)
	minimal_access = list(GLOB.access_hydroponics)
	alt_titles = list("Hydroponicist")
	outfit_type = /decl/hierarchy/outfit/job/service/gardener

//Cargo
/datum/job/qm
	title = "Quartermaster"
	department = "Supply"
	department_flag = GLOB.SUP
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	economic_modifier = 5
	access = list(GLOB.access_maint_tunnels, GLOB.access_mailsorting, GLOB.access_cargo, GLOB.access_cargo_bot, GLOB.access_qm, GLOB.access_mining, GLOB.access_mining_station)
	minimal_access = list(GLOB.access_maint_tunnels, GLOB.access_mailsorting, GLOB.access_cargo, GLOB.access_cargo_bot, GLOB.access_qm, GLOB.access_mining, GLOB.access_mining_station)
	minimal_player_age = 3
	ideal_character_age = 40
	outfit_type = /decl/hierarchy/outfit/job/cargo/qm

/datum/job/cargo_tech
	title = "Cargo Technician"
	department = "Supply"
	department_flag = GLOB.SUP
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the quartermaster and the head of personnel"
	selection_color = "#515151"
	access = list(GLOB.access_maint_tunnels, GLOB.access_mailsorting, GLOB.access_cargo, GLOB.access_cargo_bot, GLOB.access_qm, GLOB.access_mining, GLOB.access_mining_station)
	minimal_access = list(GLOB.access_maint_tunnels, GLOB.access_cargo, GLOB.access_cargo_bot, GLOB.access_mailsorting)
	outfit_type = /decl/hierarchy/outfit/job/cargo/cargo_tech

/datum/job/mining
	title = "Shaft Miner"
	department = "Supply"
	department_flag = GLOB.SUP
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the quartermaster and the head of personnel"
	selection_color = "#515151"
	economic_modifier = 5
	access = list(GLOB.access_maint_tunnels, GLOB.access_mailsorting, GLOB.access_cargo, GLOB.access_cargo_bot, GLOB.access_qm, GLOB.access_mining, GLOB.access_mining_station)
	minimal_access = list(GLOB.access_mining, GLOB.access_mining_station, GLOB.access_mailsorting)
	alt_titles = list("Drill Technician","Prospector")
	outfit_type = /decl/hierarchy/outfit/job/cargo/mining

/datum/job/janitor
	title = "Janitor"
	department = "Service"
	department_flag = GLOB.SRV
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	access = list(GLOB.access_janitor, GLOB.access_maint_tunnels, GLOB.access_engine, GLOB.access_research, GLOB.access_sec_doors, GLOB.access_medical)
	minimal_access = list(GLOB.access_janitor, GLOB.access_maint_tunnels, GLOB.access_engine, GLOB.access_research, GLOB.access_sec_doors, GLOB.access_medical)
	alt_titles = list("Custodian","Sanitation Technician")
	outfit_type = /decl/hierarchy/outfit/job/service/janitor

//More or less assistants
/datum/job/librarian
	title = "Librarian"
	department = "Civilian"
	department_flag = GLOB.CIV
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of personnel"
	selection_color = "#515151"
	access = list(GLOB.access_library, GLOB.access_maint_tunnels)
	minimal_access = list(GLOB.access_library)
	alt_titles = list("Journalist")
	outfit_type = /decl/hierarchy/outfit/job/librarian

/datum/job/lawyer
	title = "Internal Affairs Agent"
	department = "Support"
	department_flag = GLOB.SPT
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "company officials and Corporate Regulations"
	selection_color = "#515151"
	economic_modifier = 7
	access = list(GLOB.access_lawyer, GLOB.access_sec_doors, GLOB.access_maint_tunnels, GLOB.access_heads)
	minimal_access = list(GLOB.access_lawyer, GLOB.access_sec_doors, GLOB.access_heads)
	minimal_player_age = 10
	outfit_type = /decl/hierarchy/outfit/job/internal_affairs_agent
	announced = 1

/datum/job/lawyer/equip(var/mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.implant_loyalty(H)

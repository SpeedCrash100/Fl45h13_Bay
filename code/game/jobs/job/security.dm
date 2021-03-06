/datum/job/hos
	title = "Head of Security"
	head_position = 1
	department = "Security"
	department_flag = GLOB.SEC|GLOB.COM
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#8e2929"
	req_admin_notify = 1
	economic_modifier = 10
	access = list(GLOB.access_security, GLOB.access_eva, GLOB.access_sec_doors, GLOB.access_brig, GLOB.access_armory,
						GLOB.access_forensics_lockers, GLOB.access_morgue, GLOB.access_maint_tunnels, GLOB.access_all_personal_lockers,
						GLOB.access_research, GLOB.access_engine, GLOB.access_mining, GLOB.access_medical, GLOB.access_construction, GLOB.access_mailsorting,
						GLOB.access_heads, GLOB.access_hos, GLOB.access_RC_announce, GLOB.access_keycard_auth, GLOB.access_gateway, GLOB.access_external_airlocks)
	minimal_access = list(GLOB.access_security, GLOB.access_eva, GLOB.access_sec_doors, GLOB.access_brig, GLOB.access_armory,
						GLOB.access_forensics_lockers, GLOB.access_morgue, GLOB.access_maint_tunnels, GLOB.access_all_personal_lockers,
						GLOB.access_research, GLOB.access_engine, GLOB.access_mining, GLOB.access_medical, GLOB.access_construction, GLOB.access_mailsorting,
						GLOB.access_heads, GLOB.access_hos, GLOB.access_RC_announce, GLOB.access_keycard_auth, GLOB.access_gateway, GLOB.access_external_airlocks)
	minimal_player_age = 14
	outfit_type = /decl/hierarchy/outfit/job/security/hos
	announced = 1

/datum/job/hos/equip(var/mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.implant_loyalty(H)

/datum/job/warden
	title = "Warden"
	department = "Security"
	department_flag = GLOB.SEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of security"
	selection_color = "#601c1c"
	economic_modifier = 5
	access = list(GLOB.access_security, GLOB.access_eva, GLOB.access_sec_doors, GLOB.access_brig, GLOB.access_armory, GLOB.access_maint_tunnels, GLOB.access_morgue, GLOB.access_external_airlocks)
	minimal_access = list(GLOB.access_security, GLOB.access_eva, GLOB.access_sec_doors, GLOB.access_brig, GLOB.access_armory, GLOB.access_maint_tunnels, GLOB.access_external_airlocks)
	minimal_player_age = 7
	outfit_type = /decl/hierarchy/outfit/job/security/warden

/datum/job/detective
	title = "Detective"
	department = "Security"
	department_flag = GLOB.SEC
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the head of security"
	selection_color = "#601c1c"
	alt_titles = list("Forensic Technician" = /decl/hierarchy/outfit/job/security/detective/forensic)
	economic_modifier = 5
	access = list(GLOB.access_security, GLOB.access_sec_doors, GLOB.access_forensics_lockers, GLOB.access_morgue, GLOB.access_maint_tunnels)
	minimal_access = list(GLOB.access_security, GLOB.access_sec_doors, GLOB.access_forensics_lockers, GLOB.access_morgue, GLOB.access_maint_tunnels)
	minimal_player_age = 7
	outfit_type = /decl/hierarchy/outfit/job/security/detective

/datum/job/officer
	title = "Security Officer"
	department = "Security"
	department_flag = GLOB.SEC
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	supervisors = "the head of security"
	selection_color = "#601c1c"
	alt_titles = list("Junior Officer")
	economic_modifier = 4
	access = list(GLOB.access_security, GLOB.access_eva, GLOB.access_sec_doors, GLOB.access_brig, GLOB.access_maint_tunnels, GLOB.access_morgue, GLOB.access_external_airlocks)
	minimal_access = list(GLOB.access_security, GLOB.access_eva, GLOB.access_sec_doors, GLOB.access_brig, GLOB.access_maint_tunnels, GLOB.access_external_airlocks)
	minimal_player_age = 7
	outfit_type = /decl/hierarchy/outfit/job/security/officer
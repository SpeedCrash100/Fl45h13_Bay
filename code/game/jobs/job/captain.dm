GLOBAL_DATUM_INIT(captain_announcement, /datum/announcement/minor, new(do_newscast = 1))

/datum/job/captain
	title = "Captain"
	department = "Command"
	head_position = 1
	department_flag = GLOB.COM
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "company officials and Corporate Regulations"
	selection_color = "#1d1d4f"
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 14
	economic_modifier = 20

	ideal_character_age = 70 // Old geezer captains ftw
	outfit_type = /decl/hierarchy/outfit/job/captain
	announced = 1

/datum/job/captain/equip(var/mob/living/carbon/human/H)
	. = ..()
	if(.)
		H.implant_loyalty(src)

/datum/job/captain/get_access()
	return get_all_station_access()

/datum/job/hop
	title = "Head of Personnel"
	head_position = 1
	department_flag = GLOB.COM|GLOB.CIV
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#2f2f7f"
	req_admin_notify = 1
	minimal_player_age = 14
	economic_modifier = 10
	ideal_character_age = 50

	access = list(GLOB.access_security, GLOB.access_sec_doors, GLOB.access_brig, GLOB.access_forensics_lockers,
						GLOB.access_medical, GLOB.access_engine, GLOB.access_change_ids, GLOB.access_ai_upload, GLOB.access_eva, GLOB.access_heads,
						GLOB.access_all_personal_lockers, GLOB.access_maint_tunnels, GLOB.access_bar, GLOB.access_janitor, GLOB.access_construction, GLOB.access_morgue,
						GLOB.access_crematorium, GLOB.access_kitchen, GLOB.access_cargo, GLOB.access_cargo_bot, GLOB.access_mailsorting, GLOB.access_qm, GLOB.access_hydroponics, GLOB.access_lawyer,
						GLOB.access_chapel_office, GLOB.access_library, GLOB.access_research, GLOB.access_mining, GLOB.access_heads_vault, GLOB.access_mining_station,
						GLOB.access_hop, GLOB.access_RC_announce, GLOB.access_keycard_auth, GLOB.access_gateway)
	minimal_access = list(GLOB.access_security, GLOB.access_sec_doors, GLOB.access_brig, GLOB.access_forensics_lockers,
						GLOB.access_medical, GLOB.access_engine, GLOB.access_change_ids, GLOB.access_ai_upload, GLOB.access_eva, GLOB.access_heads,
						GLOB.access_all_personal_lockers, GLOB.access_maint_tunnels, GLOB.access_bar, GLOB.access_janitor, GLOB.access_construction, GLOB.access_morgue,
						GLOB.access_crematorium, GLOB.access_kitchen, GLOB.access_cargo, GLOB.access_cargo_bot, GLOB.access_mailsorting, GLOB.access_qm, GLOB.access_hydroponics, GLOB.access_lawyer,
						GLOB.access_chapel_office, GLOB.access_library, GLOB.access_research, GLOB.access_mining, GLOB.access_heads_vault, GLOB.access_mining_station,
						GLOB.access_hop, GLOB.access_RC_announce, GLOB.access_keycard_auth, GLOB.access_gateway)

	outfit_type = /decl/hierarchy/outfit/job/hop
	announced = 1
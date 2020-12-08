/datum/access
	var/id = 0
	var/desc = ""
	var/region = ACCESS_REGION_NONE
	var/access_type = ACCESS_TYPE_STATION

/datum/access/dd_SortValue()
	return "[access_type][desc]"

/*****************
* Station access *
*****************/
GLOBAL_VAR_CONST(access_security, 1)
/datum/access/security
	id = GLOB.access_security
	desc = "Security Equipment"
	region = ACCESS_REGION_SECURITY

GLOBAL_VAR_CONST(access_brig, 2) //  Brig timers and permabrig
/datum/access/holding
	id = GLOB.access_brig
	desc = "Holding Cells"
	region = ACCESS_REGION_SECURITY

GLOBAL_VAR_CONST(access_armory, 3)
/datum/access/armory
	id = GLOB.access_armory
	desc = "Armory"
	region = ACCESS_REGION_SECURITY

GLOBAL_VAR_CONST(access_forensics_lockers, 4)
/datum/access/forensics_lockers
	id = GLOB.access_forensics_lockers
	desc = "Forensics"
	region = ACCESS_REGION_SECURITY

GLOBAL_VAR_CONST(access_medical, 5)
/datum/access/medical
	id = GLOB.access_medical
	desc = "Medical"
	region = ACCESS_REGION_MEDBAY

GLOBAL_VAR_CONST(access_morgue, 6)
/datum/access/morgue
	id = GLOB.access_morgue
	desc = "Morgue"
	region = ACCESS_REGION_MEDBAY

GLOBAL_VAR_CONST(access_tox, 7)
/datum/access/tox
	id = GLOB.access_tox
	desc = "R&D Lab"
	region = ACCESS_REGION_RESEARCH

GLOBAL_VAR_CONST(access_tox_storage, 8)
/datum/access/tox_storage
	id = GLOB.access_tox_storage
	desc = "Toxins Lab"
	region = ACCESS_REGION_RESEARCH

GLOBAL_VAR_CONST(access_genetics, 9)
/datum/access/genetics
	id = GLOB.access_genetics
	desc = "Genetics Lab"
	region = ACCESS_REGION_MEDBAY

GLOBAL_VAR_CONST(access_engine, 10)
/datum/access/engine
	id = GLOB.access_engine
	desc = "Engineering"
	region = ACCESS_REGION_ENGINEERING

GLOBAL_VAR_CONST(access_engine_equip, 11)
/datum/access/engine_equip
	id = GLOB.access_engine_equip
	desc = "Engine Room"
	region = ACCESS_REGION_ENGINEERING

GLOBAL_VAR_CONST(access_maint_tunnels, 12)
/datum/access/maint_tunnels
	id = GLOB.access_maint_tunnels
	desc = "Maintenance"
	region = ACCESS_REGION_ENGINEERING

GLOBAL_VAR_CONST(access_external_airlocks, 13)
/datum/access/external_airlocks
	id = GLOB.access_external_airlocks
	desc = "External Airlocks"
	region = ACCESS_REGION_ENGINEERING

GLOBAL_VAR_CONST(access_emergency_storage, 14)
/datum/access/emergency_storage
	id = GLOB.access_emergency_storage
	desc = "Emergency Storage"
	region = ACCESS_REGION_ENGINEERING

GLOBAL_VAR_CONST(access_change_ids, 15)
/datum/access/change_ids
	id = GLOB.access_change_ids
	desc = "ID Computer"
	region = ACCESS_REGION_COMMAND

GLOBAL_VAR_CONST(access_ai_upload, 16)
/datum/access/ai_upload
	id = GLOB.access_ai_upload
	desc = "AI Upload"
	region = ACCESS_REGION_COMMAND

GLOBAL_VAR_CONST(access_teleporter, 17)
/datum/access/teleporter
	id = GLOB.access_teleporter
	desc = "Teleporter"
	region = ACCESS_REGION_COMMAND

GLOBAL_VAR_CONST(access_eva, 18)
/datum/access/eva
	id = GLOB.access_eva
	desc = "EVA"
	region = ACCESS_REGION_COMMAND

GLOBAL_VAR_CONST(access_heads, 19)
/datum/access/heads
	id = GLOB.access_heads
	desc = "Bridge"
	region = ACCESS_REGION_COMMAND

GLOBAL_VAR_CONST(access_captain, 20)
/datum/access/captain
	id = GLOB.access_captain
	desc = "Captain"
	region = ACCESS_REGION_COMMAND

GLOBAL_VAR_CONST(access_all_personal_lockers, 21)
/datum/access/all_personal_lockers
	id = GLOB.access_all_personal_lockers
	desc = "Personal Lockers"
	region = ACCESS_REGION_COMMAND

GLOBAL_VAR_CONST(access_chapel_office, 22)
/datum/access/chapel_office
	id = GLOB.access_chapel_office
	desc = "Chapel Office"
	region = ACCESS_REGION_GENERAL

GLOBAL_VAR_CONST(access_tech_storage, 23)
/datum/access/tech_storage
	id = GLOB.access_tech_storage
	desc = "Technical Storage"
	region = ACCESS_REGION_ENGINEERING

GLOBAL_VAR_CONST(access_atmospherics, 24)
/datum/access/atmospherics
	id = GLOB.access_atmospherics
	desc = "Atmospherics"
	region = ACCESS_REGION_ENGINEERING

GLOBAL_VAR_CONST(access_bar, 25)
/datum/access/bar
	id = GLOB.access_bar
	desc = "Bar"
	region = ACCESS_REGION_GENERAL

GLOBAL_VAR_CONST(access_janitor, 26)
/datum/access/janitor
	id = GLOB.access_janitor
	desc = "Custodial Closet"
	region = ACCESS_REGION_GENERAL

GLOBAL_VAR_CONST(access_crematorium, 27)
/datum/access/crematorium
	id = GLOB.access_crematorium
	desc = "Crematorium"
	region = ACCESS_REGION_GENERAL

GLOBAL_VAR_CONST(access_kitchen, 28)
/datum/access/kitchen
	id = GLOB.access_kitchen
	desc = "Kitchen"
	region = ACCESS_REGION_GENERAL

GLOBAL_VAR_CONST(access_robotics, 29)
/datum/access/robotics
	id = GLOB.access_robotics
	desc = "Robotics"
	region = ACCESS_REGION_RESEARCH

GLOBAL_VAR_CONST(access_rd, 30)
/datum/access/rd
	id = GLOB.access_rd
	desc = "Research Director"
	region = ACCESS_REGION_RESEARCH

GLOBAL_VAR_CONST(access_cargo, 31)
/datum/access/cargo
	id = GLOB.access_cargo
	desc = "Cargo Bay"
	region = ACCESS_REGION_SUPPLY

GLOBAL_VAR_CONST(access_construction, 32)
/datum/access/construction
	id = GLOB.access_construction
	desc = "Construction Areas"
	region = ACCESS_REGION_ENGINEERING

GLOBAL_VAR_CONST(access_chemistry, 33)
/datum/access/chemistry
	id = GLOB.access_chemistry
	desc = "Chemistry Lab"
	region = ACCESS_REGION_MEDBAY

GLOBAL_VAR_CONST(access_cargo_bot, 34)
/datum/access/cargo_bot
	id = GLOB.access_cargo_bot
	desc = "Cargo Bot Delivery"
	region = ACCESS_REGION_SUPPLY

GLOBAL_VAR_CONST(access_hydroponics, 35)
/datum/access/hydroponics
	id = GLOB.access_hydroponics
	desc = "Hydroponics"
	region = ACCESS_REGION_GENERAL

GLOBAL_VAR_CONST(access_manufacturing, 36)
/datum/access/manufacturing
	id = GLOB.access_manufacturing
	desc = "Manufacturing"
	access_type = ACCESS_TYPE_NONE

GLOBAL_VAR_CONST(access_library, 37)
/datum/access/library
	id = GLOB.access_library
	desc = "Library"
	region = ACCESS_REGION_GENERAL

GLOBAL_VAR_CONST(access_lawyer, 38)
/datum/access/lawyer
	id = GLOB.access_lawyer
	desc = "Internal Affairs"
	region = ACCESS_REGION_COMMAND

GLOBAL_VAR_CONST(access_virology, 39)
/datum/access/virology
	id = GLOB.access_virology
	desc = "Virology"
	region = ACCESS_REGION_MEDBAY

GLOBAL_VAR_CONST(access_cmo, 40)
/datum/access/cmo
	id = GLOB.access_cmo
	desc = "Chief Medical Officer"
	region = ACCESS_REGION_COMMAND

GLOBAL_VAR_CONST(access_qm, 41)
/datum/access/qm
	id = GLOB.access_qm
	desc = "Quartermaster"
	region = ACCESS_REGION_SUPPLY

GLOBAL_VAR_CONST(access_network, 42)
/datum/access/network
	id = GLOB.access_network
	desc = "Primary Network"
	region = ACCESS_REGION_RESEARCH

// /var/const/free_access_id = 43
// /var/const/free_access_id = 44

GLOBAL_VAR_CONST(access_surgery, 45)
/datum/access/surgery
	id = GLOB.access_surgery
	desc = "Surgery"
	region = ACCESS_REGION_MEDBAY

// /var/const/free_access_id = 46

GLOBAL_VAR_CONST(access_research, 47)
/datum/access/research
	id = GLOB.access_research
	desc = "Science"
	region = ACCESS_REGION_RESEARCH

GLOBAL_VAR_CONST(access_mining, 48)
/datum/access/mining
	id = GLOB.access_mining
	desc = "Mining"
	region = ACCESS_REGION_SUPPLY

GLOBAL_VAR_CONST(access_mining_office, 49)
/datum/access/mining_office
	id = GLOB.access_mining_office
	desc = "Mining Office"
	access_type = ACCESS_TYPE_NONE

GLOBAL_VAR_CONST(access_mailsorting, 50)
/datum/access/mailsorting
	id = GLOB.access_mailsorting
	desc = "Cargo Office"
	region = ACCESS_REGION_SUPPLY

// /var/const/free_access_id = 51
// /var/const/free_access_id = 52

GLOBAL_VAR_CONST(access_heads_vault, 53)
/datum/access/heads_vault
	id = GLOB.access_heads_vault
	desc = "Main Vault"
	region = ACCESS_REGION_COMMAND

GLOBAL_VAR_CONST(access_mining_station, 54)
/datum/access/mining_station
	id = GLOB.access_mining_station
	desc = "Mining EVA"
	region = ACCESS_REGION_SUPPLY

GLOBAL_VAR_CONST(access_xenobiology, 55)
/datum/access/xenobiology
	id = GLOB.access_xenobiology
	desc = "Xenobiology Lab"
	region = ACCESS_REGION_RESEARCH

GLOBAL_VAR_CONST(access_ce, 56)
/datum/access/ce
	id = GLOB.access_ce
	desc = "Chief Engineer"
	region = ACCESS_REGION_ENGINEERING

GLOBAL_VAR_CONST(access_hop, 57)
/datum/access/hop
	id = GLOB.access_hop
	desc = "Head of Personnel"
	region = ACCESS_REGION_COMMAND

GLOBAL_VAR_CONST(access_hos, 58)
/datum/access/hos
	id = GLOB.access_hos
	desc = "Head of Security"
	region = ACCESS_REGION_SECURITY

GLOBAL_VAR_CONST(access_RC_announce, 59) // Request console announcements
/datum/access/RC_announce
	id = GLOB.access_RC_announce
	desc = "RC Announcements"
	region = ACCESS_REGION_COMMAND

GLOBAL_VAR_CONST(access_keycard_auth, 60) // Used for events which require at least two people to confirm them
/datum/access/keycard_auth
	id = GLOB.access_keycard_auth
	desc = "Keycode Auth. Device"
	region = ACCESS_REGION_COMMAND

GLOBAL_VAR_CONST(access_tcomsat, 61) //  has access to the entire telecomms satellite / machinery
/datum/access/tcomsat
	id = GLOB.access_tcomsat
	desc = "Telecommunications"
	region = ACCESS_REGION_COMMAND

GLOBAL_VAR_CONST(access_gateway, 62)
/datum/access/gateway
	id = GLOB.access_gateway
	desc = "Gateway"
	region = ACCESS_REGION_COMMAND

GLOBAL_VAR_CONST(access_sec_doors, 63) //  Security front doors
/datum/access/sec_doors
	id = GLOB.access_sec_doors
	desc = "Security"
	region = ACCESS_REGION_SECURITY

GLOBAL_VAR_CONST(access_psychiatrist, 64) //  Psychiatrist's office
/datum/access/psychiatrist
	id = GLOB.access_psychiatrist
	desc = "Psychiatrist's Office"
	region = ACCESS_REGION_MEDBAY

GLOBAL_VAR_CONST(access_xenoarch, 65)
/datum/access/xenoarch
	id = GLOB.access_xenoarch
	desc = "Xenoarchaeology"
	region = ACCESS_REGION_RESEARCH

GLOBAL_VAR_CONST(access_medical_equip, 66)
/datum/access/medical_equip
	id = GLOB.access_medical_equip
	desc = "Medical Equipment"
	region = ACCESS_REGION_MEDBAY

/******************
* Central Command *
******************/
GLOBAL_VAR_CONST(access_cent_general, 101) // General facilities.
/datum/access/cent_general
	id = GLOB.access_cent_general
	desc = "Code Grey"
	access_type = ACCESS_TYPE_CENTCOM

GLOBAL_VAR_CONST(access_cent_thunder, 102) // Thunderdome.
/datum/access/cent_thunder
	id = GLOB.access_cent_thunder
	desc = "Code Yellow"
	access_type = ACCESS_TYPE_CENTCOM

GLOBAL_VAR_CONST(access_cent_specops, 103) // Special Ops.
/datum/access/cent_specops
	id = GLOB.access_cent_specops
	desc = "Code Black"
	access_type = ACCESS_TYPE_CENTCOM

GLOBAL_VAR_CONST(access_cent_medical, 104) // Medical/Research
/datum/access/cent_medical
	id = GLOB.access_cent_medical
	desc = "Code White"
	access_type = ACCESS_TYPE_CENTCOM

GLOBAL_VAR_CONST(access_cent_living, 105) // Living quarters.
/datum/access/cent_living
	id = GLOB.access_cent_living
	desc = "Code Green"
	access_type = ACCESS_TYPE_CENTCOM

GLOBAL_VAR_CONST(access_cent_storage, 106) // Generic storage areas.
/datum/access/cent_storage
	id = GLOB.access_cent_storage
	desc = "Code Orange"
	access_type = ACCESS_TYPE_CENTCOM

GLOBAL_VAR_CONST(access_cent_teleporter, 107) // Teleporter.
/datum/access/cent_teleporter
	id = GLOB.access_cent_teleporter
	desc = "Code Blue"
	access_type = ACCESS_TYPE_CENTCOM

GLOBAL_VAR_CONST(access_cent_creed, 108) // Creed's office.
/datum/access/cent_creed
	id = GLOB.access_cent_creed
	desc = "Code Silver"
	access_type = ACCESS_TYPE_CENTCOM

GLOBAL_VAR_CONST(access_cent_captain, 109) // Captain's office/ID comp/AI.
/datum/access/cent_captain
	id = GLOB.access_cent_captain
	desc = "Code Gold"
	access_type = ACCESS_TYPE_CENTCOM

/***************
* Antag access *
***************/
GLOBAL_VAR_CONST(access_syndicate, 150) // General Syndicate Access
/datum/access/syndicate
	id = GLOB.access_syndicate
	desc = "Syndicate"
	access_type = ACCESS_TYPE_SYNDICATE

/*******
* Misc *
*******/
GLOBAL_VAR_CONST(access_synth, 199)
/datum/access/synthetic
	id = GLOB.access_synth
	desc = "Synthetic"
	access_type = ACCESS_TYPE_NONE

GLOBAL_VAR_CONST(access_crate_cash, 200)
/datum/access/crate_cash
	id = GLOB.access_crate_cash
	desc = "Crate cash"
	access_type = ACCESS_TYPE_NONE

GLOBAL_VAR_CONST(access_merchant, 201)
/datum/access/merchant
	id = GLOB.access_merchant
	desc = "Merchant"
	access_type = ACCESS_TYPE_NONE

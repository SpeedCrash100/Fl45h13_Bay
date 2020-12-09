// GLOBAL_LIST_EMPTY(seen_citizenships)
// GLOBAL_LIST_EMPTY(seen_systems)
// GLOBAL_LIST_EMPTY(seen_factions)
// GLOBAL_LIST_EMPTY(seen_religions)

//Commenting this out for now until I work the lists it into the event generator/journalist/chaplain.
/proc/UpdateFactionList(mob/living/carbon/human/M)
	/*if(M && M.client && M.client.prefs)
		seen_citizenships |= M.client.prefs.citizenship
		seen_systems      |= M.client.prefs.home_system
		seen_factions     |= M.client.prefs.faction
		seen_religions    |= M.client.prefs.religion*/
	return

GLOBAL_LIST_INIT(citizenship_choices, list(
	"Earth",
	"Mars",
	"Moghes",
	"Ahdomai",
	"Qerrbalak"
	))

GLOBAL_LIST_INIT(home_system_choices, list(
	"Sol",
	"Nyx",
	"Tau Ceti",
	"Epsilon Ursae Minoris",
	"S'randarr"
	))

GLOBAL_LIST_INIT(faction_choices, list(
	"Sol Central Government",
	"Vey Med",
	"Einstein Engines",
	"Free Trade Union",
	"NanoTrasen",
	"Ward-Takahashi GMB",
	"Gilthari Exports",
	"Grayson Manufactories Ltd.",
	"Aether Atmospherics",
	"Zeng-Hu Pharmaceuticals",
	"Hephaestus Industries"
	))

GLOBAL_LIST_INIT(religion_choices, list(
	"Unitarianism",
	"Hinduism",
	"Buddhist",
	"Islamic",
	"Christian",
	"Agnostic",
	"Deist"
	))
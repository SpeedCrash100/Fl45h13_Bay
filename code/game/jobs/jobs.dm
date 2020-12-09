GLOBAL_VAR_CONST(ENG, (1<<0))
GLOBAL_VAR_CONST(SEC, (1<<1))
GLOBAL_VAR_CONST(MED, (1<<2))
GLOBAL_VAR_CONST(SCI, (1<<3))
GLOBAL_VAR_CONST(CIV, (1<<4))
GLOBAL_VAR_CONST(COM, (1<<5))
GLOBAL_VAR_CONST(CRG, (1<<6))
GLOBAL_VAR_CONST(MSC, (1<<7))
GLOBAL_VAR_CONST(SRV, (1<<8))
GLOBAL_VAR_CONST(SUP, (1<<9))
GLOBAL_VAR_CONST(SPT, (1<<10))

// GLOBAL_LIST_EMPTY(assistant_occupations)

GLOBAL_LIST_EMPTY(command_positions)

GLOBAL_LIST_EMPTY(engineering_positions)

GLOBAL_LIST_EMPTY(medical_positions)

GLOBAL_LIST_EMPTY(science_positions)

GLOBAL_LIST_EMPTY(cargo_positions)

GLOBAL_LIST_EMPTY(civilian_positions)


GLOBAL_LIST_EMPTY(security_positions)

GLOBAL_LIST_INIT(nonhuman_positions, list(
	"pAI"
))

GLOBAL_LIST_EMPTY(service_positions)

GLOBAL_LIST_EMPTY(supply_positions)

GLOBAL_LIST_EMPTY(support_positions)


/proc/guest_jobbans(var/job)
	return ((job in GLOB.command_positions) || (job in nonhuman_positions) || (job in GLOB.security_positions))

/proc/get_job_datums()
	var/list/occupations = list()
	var/list/all_jobs = typesof(/datum/job)

	for(var/A in all_jobs)
		var/datum/job/job = new A()
		if(!job)	continue
		occupations += job

	return occupations

/proc/get_alternate_titles(var/job)
	var/list/jobs = get_job_datums()
	var/list/titles = list()

	for(var/datum/job/J in jobs)
		if(J.title == job)
			titles = J.alt_titles

	return titles

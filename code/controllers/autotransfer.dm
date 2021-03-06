GLOBAL_DATUM(transfer_controller, /datum/controller/transfer_controller)

datum/controller/transfer_controller
	var/timerbuffer = 0 //buffer for time check

datum/controller/transfer_controller/New()
	timerbuffer = GLOB.config.vote_autotransfer_initial
	GLOB.processing_objects += src

datum/controller/transfer_controller/Destroy()
	GLOB.processing_objects -= src
	return ..()

datum/controller/transfer_controller/proc/process()
	if (time_till_transfer_vote() <= 0)
		GLOB.vote.autotransfer()
		timerbuffer += GLOB.config.vote_autotransfer_interval

datum/controller/transfer_controller/proc/time_till_transfer_vote()
	return timerbuffer - round_duration_in_ticks - (1 MINUTE)

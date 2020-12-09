GLOBAL_DATUM(tickerProcess, /datum/controller/process/ticker)

/datum/controller/process/ticker
	var/lastTickerTimeDuration
	var/lastTickerTime

/datum/controller/process/ticker/setup()
	name = "ticker"
	schedule_interval = 20 // every 2 seconds

	lastTickerTime = world.timeofday

	if(!GLOB.ticker)
		GLOB.ticker = new

	GLOB.tickerProcess = src

	spawn(0)
		if(GLOB.ticker)
			GLOB.ticker.pregame()

/datum/controller/process/ticker/doWork()
	var/currentTime = world.timeofday

	if(currentTime < lastTickerTime) // check for midnight rollover
		lastTickerTimeDuration = (currentTime - (lastTickerTime - TICKS_IN_DAY)) / TICKS_IN_SECOND
	else
		lastTickerTimeDuration = (currentTime - lastTickerTime) / TICKS_IN_SECOND

	lastTickerTime = currentTime

	GLOB.ticker.process()

/datum/controller/process/ticker/proc/getLastTickerTimeDuration()
	return lastTickerTimeDuration

/world/proc/has_round_started()
	return (GLOB.ticker && GLOB.ticker.current_state >= GAME_STATE_PLAYING)

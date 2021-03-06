#define SECOND *10
#define SECONDS *10

#define MINUTE *600
#define MINUTES *600

#define HOUR *36000
#define HOURS *36000

#define DAY *864000
#define DAYS *864000

#define TimeOfGame (get_game_time())
#define TimeOfTick (world.tick_usage*0.01*world.tick_lag)
/proc/get_game_time()
	var/global/time_offset = 0
	var/global/last_time = 0
	var/global/last_usage = 0

	var/wtime = world.time
	var/wusage = world.tick_usage * 0.01

	if(last_time < wtime && last_usage > 1)
		time_offset += last_usage - 1

	last_time = wtime
	last_usage = wusage

	return wtime + (time_offset + wusage) * world.tick_lag

GLOBAL_VAR(roundstart_hour)
GLOBAL_VAR_INIT(station_date, "")
GLOBAL_VAR_INIT(next_station_date_change, 1 DAY)

#define duration2stationtime(time) time2text(station_time_in_ticks + time, "hh:mm")
#define worldtime2stationtime(time) time2text(GLOB.roundstart_hour HOURS + time, "hh:mm")
#define round_duration_in_ticks (GLOB.round_start_time ? world.time - GLOB.round_start_time : 0)
#define station_time_in_ticks (GLOB.roundstart_hour HOURS + round_duration_in_ticks)

/proc/stationtime2text()
	return time2text(station_time_in_ticks, "hh:mm")

/proc/stationdate2text()
	var/update_time = FALSE
	if(station_time_in_ticks > GLOB.next_station_date_change)
		GLOB.next_station_date_change += 1 DAY
		update_time = TRUE
	if(!GLOB.station_date || update_time)
		var/extra_days = round(station_time_in_ticks / (1 DAY)) DAYS
		var/timeofday = world.timeofday + extra_days
		GLOB.station_date = num2text((text2num(time2text(timeofday, "YYYY"))+544)) + "-" + time2text(timeofday, "MM-DD")
	return GLOB.station_date

/proc/time_stamp()
	return time2text(station_time_in_ticks, "hh:mm:ss")

/* Returns 1 if it is the selected month and day */
proc/isDay(var/month, var/day)
	if(isnum(month) && isnum(day))
		var/MM = text2num(time2text(world.timeofday, "MM")) // get the current month
		var/DD = text2num(time2text(world.timeofday, "DD")) // get the current day
		if(month == MM && day == DD)
			return 1

		// Uncomment this out when debugging!
		//else
			//return 1

GLOBAL_VAR_INIT(next_duration_update, 0)
GLOBAL_VAR_INIT(last_round_duration, 0)
GLOBAL_VAR_INIT(round_start_time, 0)

/hook/roundstart/proc/start_timer()
	GLOB.round_start_time = world.time
	return 1

/proc/roundduration2text()
	if(!GLOB.round_start_time)
		return "00:00"
	if(GLOB.last_round_duration && world.time < GLOB.next_duration_update)
		return GLOB.last_round_duration

	var/mills = round_duration_in_ticks // 1/10 of a second, not real milliseconds but whatever
	//var/secs = ((mills % 36000) % 600) / 10 //Not really needed, but I'll leave it here for refrence.. or something
	var/mins = round((mills % 36000) / 600)
	var/hours = round(mills / 36000)

	mins = mins < 10 ? add_zero(mins, 1) : mins
	hours = hours < 10 ? add_zero(hours, 1) : hours

	GLOB.last_round_duration = "[hours]:[mins]"
	GLOB.next_duration_update = world.time + 1 MINUTES
	return GLOB.last_round_duration

//Can be useful for things dependent on process timing
/proc/process_schedule_interval(var/process_name)
	var/datum/controller/process/process = GLOB.processScheduler.getProcess(process_name)
	return process.schedule_interval

/hook/startup/proc/set_roundstart_hour()
	GLOB.roundstart_hour = pick(2,7,12,17)
	return 1

GLOBAL_VAR_INIT(midnight_rollovers, 0)
GLOBAL_VAR_INIT(rollovercheck_last_timeofday, 0)
/proc/update_midnight_rollover()
	if (world.timeofday < GLOB.rollovercheck_last_timeofday) //TIME IS GOING BACKWARDS!
		return GLOB.midnight_rollovers++
	return GLOB.midnight_rollovers

//Increases delay as the server gets more overloaded,
//as sleeps aren't cheap and sleeping only to wake up and sleep again is wasteful
#define DELTA_CALC max(((max(world.tick_usage, world.cpu) / 100) * max(Master.sleep_delta,1)), 1)

/proc/stoplag()
	. = 0
	var/i = 1
	do
		. += round(i*DELTA_CALC)
		sleep(i*world.tick_lag*DELTA_CALC)
		i *= 2
	while (world.tick_usage > min(TICK_LIMIT_TO_RUN, Master.current_ticklimit))

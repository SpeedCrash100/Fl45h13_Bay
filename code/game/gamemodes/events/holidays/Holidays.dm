//Uncommenting ALLOW_HOLIDAYS in config.txt will enable Holidays
GLOBAL_VAR_INIT(Holiday, null) //Just thinking ahead! Here's the foundations to a more robust Holiday event system.
//It's easy as hell to add stuff. Just set GLOB.Holiday to something using the switch (or something else)
//then use if(GLOB.Holiday == "MyHoliday") to make stuff happen on that specific day only
//Please, Don't spam stuff up with easter eggs, I'd rather somebody just delete this than people cause
//the game to lag even more in the name of one-day content.

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//ALSO, MOST IMPORTANTLY: Don't add stupid stuff! Discuss bonus content with Project-Heads first please!//
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//																							~Carn

/hook/startup/proc/updateHoliday()
	Get_Holiday()
	return 1

//sets up the Holiday global variable. Shouldbe called on game configuration or something.
/proc/Get_Holiday()
	if(!GLOB.Holiday)	return		// Holiday stuff was not enabled in the config!

	GLOB.Holiday = null				// reset our switch now so we can recycle it as our Holiday name

	var/YY	=	text2num(time2text(world.timeofday, "YY")) 	// get the current year
	var/MM	=	text2num(time2text(world.timeofday, "MM")) 	// get the current month
	var/DD	=	text2num(time2text(world.timeofday, "DD")) 	// get the current day

	//Main switch. If any of these are too dumb/inappropriate, or you have better ones, feel free to change whatever
	switch(MM)
		if(1)	//Jan
			switch(DD)
				if(1)							GLOB.Holiday = "New Year's Day"

		if(2)	//Feb
			switch(DD)
				if(2)							GLOB.Holiday = "Groundhog Day"
				if(14)							GLOB.Holiday = "Valentine's Day"
				if(17)							GLOB.Holiday = "Random Acts of Kindness Day"

		if(3)	//Mar
			switch(DD)
				if(14)							GLOB.Holiday = "Pi Day"
				if(17)							GLOB.Holiday = "St. Patrick's Day"
				if(27)
					if(YY == 16)
						GLOB.Holiday = "Easter"
				if(31)
					if(YY == 13)
						GLOB.Holiday = "Easter"

		if(4)	//Apr
			switch(DD)
				if(1)
					GLOB.Holiday = "April Fool's Day"
					if(YY == 18 && prob(50)) 	GLOB.Holiday = "Easter"
				if(5)
					if(YY == 15)				GLOB.Holiday = "Easter"
				if(16)
					if(YY == 17)				GLOB.Holiday = "Easter"
				if(20)
					GLOB.Holiday = "Four-Twenty"
					if(YY == 14 && prob(50))	GLOB.Holiday = "Easter"
				if(22)							GLOB.Holiday = "Earth Day"

		if(5)	//May
			switch(DD)
				if(1)							GLOB.Holiday = "Labour Day"
				if(4)							GLOB.Holiday = "FireFighter's Day"
				if(12)							GLOB.Holiday = "Owl and Pussycat Day"	//what a dumb day of observence...but we -do- have costumes already :3

		if(6)	//Jun

		if(7)	//Jul
			switch(DD)
				if(1)							GLOB.Holiday = "Doctor's Day"
				if(2)							GLOB.Holiday = "UFO Day"
				if(8)							GLOB.Holiday = "Writer's Day"
				if(30)							GLOB.Holiday = "Friendship Day"

		if(8)	//Aug
			switch(DD)
				if(5)							GLOB.Holiday = "Beer Day"

		if(9)	//Sep
			switch(DD)
				if(19)							GLOB.Holiday = "Talk-Like-a-Pirate Day"
				if(28)							GLOB.Holiday = "Stupid-Questions Day"

		if(10)	//Oct
			switch(DD)
				if(4)							GLOB.Holiday = "Animal's Day"
				if(7)							GLOB.Holiday = "Smiling Day"
				if(16)							GLOB.Holiday = "Boss' Day"
				if(31)							GLOB.Holiday = "Halloween"

		if(11)	//Nov
			switch(DD)
				if(1)							GLOB.Holiday = "Vegan Day"
				if(13)							GLOB.Holiday = "Kindness Day"
				if(19)							GLOB.Holiday = "Flowers Day"
				if(21)							GLOB.Holiday = "Saying-'Hello' Day"

		if(12)	//Dec
			switch(DD)
				if(10)							GLOB.Holiday = "Human-Rights Day"
				if(14)							GLOB.Holiday = "Monkey Day"
				if(21)							if(YY==12)	GLOB.Holiday = "End of the World"
				if(22)							GLOB.Holiday = "Orgasming Day"		//lol. These all actually exist
				if(24)							GLOB.Holiday = "Christmas Eve"
				if(25)							GLOB.Holiday = "Christmas"
				if(26)							GLOB.Holiday = "Boxing Day"
				if(31)							GLOB.Holiday = "New Year's Eve"

	if(!GLOB.Holiday)
		//Friday the 13th
		if(DD == 13)
			if(time2text(world.timeofday, "DDD") == "Fri")
				GLOB.Holiday = "Friday the 13th"

//Allows GA and GM to set the Holiday variable
/client/proc/Set_Holiday(T as text|null)
	set name = ".Set Holiday"
	set category = "Fun"
	set desc = "Force-set the Holiday variable to make the game think it's a certain day."
	if(!check_rights(R_SERVER))	return

	GLOB.Holiday = T
	//get a new station name
	GLOB.using_map.station_name = null
	station_name()
	//update our hub status
	world.update_status()
	Holiday_Game_Start()

	message_admins("<span class='notice'>ADMIN: Event: [key_name(src)] force-set Holiday to \"[GLOB.Holiday]\"</span>")
	log_admin("[key_name(src)] force-set Holiday to \"[GLOB.Holiday]\"")


//Run at the  start of a round
/proc/Holiday_Game_Start()
	if(GLOB.Holiday)
		to_world("<font color='blue'>and...</font>")
		to_world("<h4>Happy [GLOB.Holiday] Everybody!</h4>")
		switch(GLOB.Holiday)			//special holidays
			if("Easter")
				//do easter stuff
			if("Christmas Eve","Christmas")
				Christmas_Game_Start()

	return

//Nested in the random events loop. Will be triggered every 2 minutes
/proc/Holiday_Random_Event()
	switch(GLOB.Holiday)			//special holidays

		if("",null)			//no GLOB.Holiday today! Back to work!
			return

		if("Easter")		//I'll make this into some helper procs at some point
/*			var/list/turf/simulated/floor/Floorlist = list()
			for(var/turf/simulated/floor/T)
				if(T.contents)
					Floorlist += T
			var/turf/simulated/floor/F = Floorlist[rand(1,Floorlist.len)]
			Floorlist = null
			var/obj/structure/closet/C = locate(/obj/structure/closet) in F
			var/obj/item/weapon/reagent_containers/food/snacks/chocolateegg/wrapped/Egg
			if( C )			Egg = new(C)
			else			Egg = new(F)
*/
/*			var/list/obj/containers = list()
			for(var/obj/item/weapon/storage/S in world)
				if(isNotStationLevel(S.z))	continue
				containers += S

			message_admins("<span class='notice'>DEBUG: Event: Egg spawned at [Egg.loc] ([Egg.x],[Egg.y],[Egg.z])</span>")*/
		if("End of the World")
			if(prob(GLOB.eventchance))	GameOver()

		if("Christmas","Christmas Eve")
			if(prob(GLOB.eventchance))	ChristmasEvent()

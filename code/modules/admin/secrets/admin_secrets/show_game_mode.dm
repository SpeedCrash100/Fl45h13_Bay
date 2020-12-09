/datum/admin_secret_item/admin_secret/show_game_mode
	name = "Show Game Mode"

/datum/admin_secret_item/admin_secret/show_game_mode/can_execute(var/mob/user)
	if(!GLOB.ticker)
		return 0
	return ..()

/datum/admin_secret_item/admin_secret/show_game_mode/execute(var/mob/user)
	. = ..()
	if(!.)
		return
	if (GLOB.ticker.mode) alert("The game mode is [GLOB.ticker.mode.name]")
	else alert("For some reason there's a GLOB.ticker, but not a game mode")

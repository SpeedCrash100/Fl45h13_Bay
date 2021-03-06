GLOBAL_DATUM_INIT(lobby_image, /obj/effect, new/obj/effect/lobby_image())

/obj/effect/lobby_image
	name = "Baystation12"
	desc = "This shouldn't be read."
	screen_loc = "WEST,SOUTH"

/obj/effect/lobby_image/initialize()
	icon = GLOB.using_map.lobby_icon
	var/known_icon_states = icon_states(icon)
	for(var/lobby_screen in GLOB.using_map.lobby_screens)
		if(!(lobby_screen in known_icon_states))
			error("Lobby screen '[lobby_screen]' did not exist in the icon set [icon].")
			GLOB.using_map.lobby_screens -= lobby_screen

	if(GLOB.using_map.lobby_screens.len)
		icon_state = pick(GLOB.using_map.lobby_screens)
	else
		icon_state = known_icon_states[1]

/mob/new_player/Login()
	update_Login_details()	//handles setting lastKnownIP and computer_id for use by the ban systems as well as checking for multikeying
	if(GLOB.join_motd)
		to_chat(src, "<div class=\"motd\">[GLOB.join_motd]</div>")
	to_chat(src, "<div class='info'>Game ID: <div class='danger'>[GLOB.game_id]</div></div>")

	if(!mind)
		mind = new /datum/mind(key)
		mind.active = 1
		mind.current = src

	loc = null
	client.screen += GLOB.lobby_image
	my_client = client
	set_sight(sight|SEE_TURFS)
	GLOB.player_list |= src

	new_player_panel()

	if(!SScharacter_setup.initialized)
		SScharacter_setup.newplayers_requiring_init += src
	else
		deferred_login()

/mob/new_player/proc/deferred_login()
	if(client)
		handle_privacy_poll()
		client.playtitlemusic()
		maybe_send_staffwarns("connected as new player")

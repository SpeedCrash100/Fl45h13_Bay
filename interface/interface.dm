//Please use mob or src (not usr) in these procs. This way they can be called in the same fashion as procs.
/client/verb/wiki()
	set name = "wiki"
	set desc = "Visit the wiki."
	set hidden = 1
	if( GLOB.config.wikiurl )
		if(alert("This will open the wiki in your browser. Are you sure?",,"Yes","No")=="No")
			return
		send_link(src, GLOB.config.wikiurl)
	else
		to_chat(src, "<span class='warning'>The wiki URL is not set in the server configuration.</span>")
	return

/client/verb/forum()
	set name = "forum"
	set desc = "Visit the forum."
	set hidden = 1
	if( GLOB.config.forumurl )
		if(alert("This will open the forum in your browser. Are you sure?",,"Yes","No")=="No")
			return
		send_link(src, GLOB.config.forumurl)
	else
		to_chat(src, "<span class='warning'>The forum URL is not set in the server configuration.</span>")
	return

#define RULES_FILE "config/rules.html"
/client/verb/rules()
	set name = "Rules"
	set desc = "Show Server Rules."
	set hidden = 1
	show_browser(src, file(RULES_FILE), "window=rules;size=480x320")
#undef RULES_FILE

/client/verb/github()
	set name = "GitHub"
	set desc = "Visit the GitHub repository."
	set hidden = 1
	if( GLOB.config.githuburl )
		if(alert("This will open GitHub in your browser. Are you sure?",,"Yes","No")=="No")
			return
		send_link(src, GLOB.config.githuburl)
	else
		to_chat(src, "<span class='warning'>The github URL is not set in the server configuration.</span>")
	return

/client/verb/bugreport()
	set name = "Bug Report"
	set desc = "Visit the GitHub repository to report an issue or bug."
	set hidden = 1
	if( GLOB.config.issuereporturl )
		if(alert("This will open GitHub in your browser. Are you sure?",,"Yes","No")=="No")
			return
		send_link(src, GLOB.config.issuereporturl)
	else
		to_chat(src, "<span class='warning'>The issue report URL is not set in the server configuration.</span>")
	return

/client/verb/hotkeys_help()
	set name = "hotkeys-help"
	set category = "OOC"

	var/admin = {"<font color='purple'>
Admin:
\tF5 = Aghost (admin-ghost)
\tF6 = player-panel-new
\tF7 = admin-pm
\tF8 = Invisimin
</font>"}

	var/hotkey_mode = {"<font color='purple'>
Hotkey-Mode: (hotkey-mode must be on)
\tTAB = toggle hotkey-mode
\ta = left
\ts = down
\td = right
\tw = up
\t, = move-upwards
\t. = move-down
\tq = drop
\te = equip
\tr = throw
\tt = say
\t5 = emote
\tx = swap-hand
\tz = activate held object (or y)
\tj = toggle-aiming-mode
\tf = cycle-GLOB.intents-left
\tg = cycle-GLOB.intents-right
\t1 = help-intent
\t2 = disarm-intent
\t3 = grab-intent
\t4 = harm-intent
\tCtrl = drag
\tShift = examine
</font>"}

	var/other = {"<font color='purple'>
Any-Mode: (hotkey doesn't need to be on)
\tCtrl+a = left
\tCtrl+s = down
\tCtrl+d = right
\tCtrl+w = up
\tCtrl+q = drop
\tCtrl+e = equip
\tCtrl+r = throw
\tCtrl+x = swap-hand
\tCtrl+z = activate held object (or Ctrl+y)
\tCtrl+f = cycle-GLOB.intents-left
\tCtrl+g = cycle-GLOB.intents-right
\tCtrl+1 = help-intent
\tCtrl+2 = disarm-intent
\tCtrl+3 = grab-intent
\tCtrl+4 = harm-intent
\tF1 = adminhelp
\tF2 = ooc
\tF3 = say
\tF4 = emote
\tDEL = pull
\tINS = cycle-GLOB.intents-right
\tHOME = drop
\tPGUP = swap-hand
\tPGDN = activate held object
\tEND = throw
</font>"}

	var/robot_hotkey_mode = {"<font color='purple'>
Hotkey-Mode: (hotkey-mode must be on)
\tTAB = toggle hotkey-mode
\ta = left
\ts = down
\td = right
\tw = up
\tq = unequip active module
\tt = say
\tx = cycle active modules
\tz = activate held object (or y)
\tf = cycle-GLOB.intents-left
\tg = cycle-GLOB.intents-right
\t1 = activate module 1
\t2 = activate module 2
\t3 = activate module 3
\t4 = toggle intents
\t5 = emote
\tCtrl = drag
\tShift = examine
</font>"}

	var/robot_other = {"<font color='purple'>
Any-Mode: (hotkey doesn't need to be on)
\tCtrl+a = left
\tCtrl+s = down
\tCtrl+d = right
\tCtrl+w = up
\tCtrl+q = unequip active module
\tCtrl+x = cycle active modules
\tCtrl+z = activate held object (or Ctrl+y)
\tCtrl+f = cycle-GLOB.intents-left
\tCtrl+g = cycle-GLOB.intents-right
\tCtrl+1 = activate module 1
\tCtrl+2 = activate module 2
\tCtrl+3 = activate module 3
\tCtrl+4 = toggle intents
\tF1 = adminhelp
\tF2 = ooc
\tF3 = say
\tF4 = emote
\tDEL = pull
\tINS = toggle intents
\tPGUP = cycle active modules
\tPGDN = activate held object
</font>"}

	if(isrobot(src.mob))
		to_chat(src, robot_hotkey_mode)
		to_chat(src, robot_other)
	else
		to_chat(src, hotkey_mode)
		to_chat(src, other)
	if(holder)
		to_chat(src, admin)

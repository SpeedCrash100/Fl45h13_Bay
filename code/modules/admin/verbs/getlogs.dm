/*
	HOW DO I LOG RUNTIMES?
	Firstly, start dreamdeamon if it isn't already running. Then select "world>Log Session" (or press the F3 key)
	navigate the popup window to the data/logs/runtime/ folder from where your tgstation .dmb is located.
	(you may have to make this folder yourself)

	OPTIONAL: 	you can select the little checkbox down the bottom to make dreamdeamon save the log everytime you
				start a world. Just remember to repeat these steps with a new name when you update to a new revision!

	Save it with the name of the revision your server uses (e.g. r3459.txt).
	Game Masters will now be able to grant access any runtime logs you have archived this way!
	This will allow us to gather information on bugs across multiple servers and make maintaining the TG
	codebase for the entire /TG/station commuity a TONNE easier :3 Thanks for your help!
*/
//Used to view or download any logs
/client/proc/get_log(var/path)
	if(file_spam_check())
		return

	if(!fexists(path))
		return

	message_admins("[key_name_admin(src)] accessed file: [path]")

	switch(alert("View (in game) or Download?", path, "View", "Download"))
		if ("View")
			src << browse("<pre style='word-wrap: break-word;'>[html_encode(file2text(file(path)))]</pre>", list2params(list("window" = "viewfile.[path]")))
		if ("Download")
			to_chat(src, "Attempting to send [path], this may take a fair few minutes if the file is very large.")
			src << ftp(file(path))
		else
			return

	return

//Provides logfiles from data/logs folder
/client/proc/fetch_server_logs()
	set name = "Fetch Server Logs"
	set desc = "Fetch logfiles from data/logs"
	set category = "Admin"

	var/path = browse_files("data/logs/")

	if(!path)
		return

	get_log(path)

//Provides today's logfile
/client/proc/fetch_current_log()
	set name = "Fetch Current Log"
	set desc = "Fetch today's server log"
	set category = "Admin"

	var/path = "data/logs/[time2text(world.realtime,"YYYY/MM-Month/DD-Day")].log"

	get_log(path)

//Provides today's attack logfile
/client/proc/fetch_attack_log()
	set name = "Fetch Attack Log"
	set desc = "Fetch today's server log"
	set category = "Admin"

	var/path = "data/logs/[time2text(world.realtime,"YYYY/MM-Month/DD-Day")] Attack.log"

	get_log(path)

GLOBAL_VAR_INIT(create_turf_html, null) 
/datum/admins/proc/create_turf(var/mob/user)
	if (!GLOB.create_turf_html)
		var/turfjs = null
		turfjs = jointext(typesof(/turf), ";")
		GLOB.create_turf_html = file2text('html/create_object.html')
		GLOB.create_turf_html = replacetext(GLOB.create_turf_html, "null /* object types */", "\"[turfjs]\"")

	show_browser(user, replacetext(GLOB.create_turf_html, "/* ref src */", "\ref[src]"), "window=create_turf;size=425x475")

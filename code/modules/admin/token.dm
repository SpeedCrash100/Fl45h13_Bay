// TODO! use tokens in
// /proc/GenerateToken()
// 	. = ""
// 	for(var/I in 1 to 32)
// 		. += "[rand(10)]"

// /proc/RawHrefToken(forceGlobal = FALSE)
// 	var/tok = GLOB.href_token
// 	if(!forceGlobal && usr)
// 		var/client/C = usr.client
// 		if(!C)
// 			CRASH("No client for HrefToken()!")
// 		var/datum/admins/holder = C.holder
// 		if(holder)
// 			tok = holder.href_token
// 	return tok

/proc/HrefToken(forceGlobal = FALSE)
    return ""
	// return "admin_token=[RawHrefToken(forceGlobal)]"

// /proc/HrefTokenFormField(forceGlobal = FALSE)
// 	return "<input type='hidden' name='admin_token' value='[RawHrefToken(forceGlobal)]'>"
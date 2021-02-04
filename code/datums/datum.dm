/datum
	/**
	  * Tick count time when this object was destroyed.
	  *
	  * If this is non zero then the object has been garbage collected and is awaiting either
	  * a hard del by the GC subsystme, or to be autocollected (if it has no references)
	  */
	var/gc_destroyed

	/// Datum level flags
	var/datum_flags = NONE


/datum/proc/CanProcCall(procname)
	return TRUE

/datum/proc/can_vv_get(var_name)
	return TRUE

/datum/proc/vv_edit_var(var_name, var_value) //called whenever a var is edited
	if(var_name == NAMEOF(src, vars))
		return FALSE
	vars[var_name] = var_value
	datum_flags |= DF_VAR_EDITED
	return TRUE

/datum/proc/vv_get_var(var_name)
	switch(var_name)
		if ("vars")
			return debug_variable(var_name, list(), 0, src)
	return debug_variable(var_name, vars[var_name], 0, src)

/datum/proc/can_vv_mark()
	return TRUE

//please call . = ..() first and append to the result, that way parent items are always at the top and child items are further down
//add separaters by doing . += "---"
/datum/proc/vv_get_dropdown()
	. = list()
	VV_DROPDOWN_OPTION("", "---")
	VV_DROPDOWN_OPTION(VV_HK_CALLPROC, "Call Proc")
	VV_DROPDOWN_OPTION(VV_HK_MARK, "Mark Object")
	VV_DROPDOWN_OPTION(VV_HK_DELETE, "Delete")
	VV_DROPDOWN_OPTION(VV_HK_EXPOSE, "Show VV To Player")
	#ifdef REFERENCE_TRACKING
	VV_DROPDOWN_OPTION(VV_HK_VIEW_REFERENCES, "View References")
	#endif

//This proc is only called if everything topic-wise is verified. The only verifications that should happen here is things like permission checks!
//href_list is a reference, modifying it in these procs WILL change the rest of the proc in topic.dm of admin/view_variables!
//This proc is for "high level" actions like admin heal/set species/etc/etc. The low level debugging things should go in admin/view_variables/topic_basic.dm incase this runtimes.
/datum/proc/vv_do_topic(list/href_list)
	if(!usr || !usr.client || !usr.client.holder || !check_rights(NONE))
		return FALSE			//This is VV, not to be called by anything else.
	return TRUE

/datum/proc/vv_get_header()
	. = list()
	if(("name" in vars) && !isatom(src))
		. += "<b>[vars["name"]]</b><br>"

/**
 * Default implementation of clean-up code.
 *
 * This should be overridden to remove all references pointing to the object being destroyed, if
 * you do override it, make sure to call the parent and return it's return value by default
 *
 * Return an appropriate [QDEL_HINT][QDEL_HINT_QUEUE] to modify handling of your deletion;
 * in most cases this is [QDEL_HINT_QUEUE].
 *
 * The base case is responsible for doing the following
 * * Erasing timers pointing to this datum
 * * Erasing compenents on this datum
 * * Notifying datums listening to signals from this datum that we are going away
 *
 * Returns [QDEL_HINT_QUEUE]
 */
/datum/proc/Destroy(force=FALSE, ...)
	tag = null
	GLOB.nanomanager.close_uis(src)
	return QDEL_HINT_QUEUE
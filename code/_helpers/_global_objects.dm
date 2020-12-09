GLOBAL_DATUM(gear_tweak_free_color_choice_, /datum/gear_tweak/color)
/proc/gear_tweak_free_color_choice()
	if(!GLOB.gear_tweak_free_color_choice_) GLOB.gear_tweak_free_color_choice_ = new()
	return GLOB.gear_tweak_free_color_choice_

//var/datum/gear_tweak/color/gear_tweak_free_color_choice_
//#define gear_tweak_free_color_choice (GLOB.gear_tweak_free_color_choice_ ? GLOB.gear_tweak_free_color_choice_ : (GLOB.gear_tweak_free_color_choice_ = new()))
// Might work in 511 assuming x=y=5 gets implemented.

GLOBAL_LIST_INIT(lunchables_lunches_, list(/obj/item/weapon/reagent_containers/food/snacks/sandwich,
								  /obj/item/weapon/reagent_containers/food/snacks/slice/meatbread/filled,
								  /obj/item/weapon/reagent_containers/food/snacks/slice/tofubread/filled,
								  /obj/item/weapon/reagent_containers/food/snacks/slice/creamcheesebread/filled,
								  /obj/item/weapon/reagent_containers/food/snacks/slice/margherita/filled,
								  /obj/item/weapon/reagent_containers/food/snacks/slice/meatpizza/filled,
								  /obj/item/weapon/reagent_containers/food/snacks/slice/mushroompizza/filled,
								  /obj/item/weapon/reagent_containers/food/snacks/slice/vegetablepizza/filled,
								  /obj/item/weapon/reagent_containers/food/snacks/tastybread,
								  /obj/item/weapon/reagent_containers/food/snacks/liquidfood,
								  /obj/item/weapon/reagent_containers/food/snacks/jellysandwich/cherry,
								  /obj/item/weapon/reagent_containers/food/snacks/tossedsalad))

GLOBAL_LIST_INIT(lunchables_snacks_, list(/obj/item/weapon/reagent_containers/food/snacks/donut/jelly,
								   /obj/item/weapon/reagent_containers/food/snacks/donut/cherryjelly,
								   /obj/item/weapon/reagent_containers/food/snacks/muffin,
								   /obj/item/weapon/reagent_containers/food/snacks/popcorn,
								   /obj/item/weapon/reagent_containers/food/snacks/sosjerky,
								   /obj/item/weapon/reagent_containers/food/snacks/no_raisin,
								   /obj/item/weapon/reagent_containers/food/snacks/spacetwinkie,
								   /obj/item/weapon/reagent_containers/food/snacks/cheesiehonkers,
								   /obj/item/weapon/reagent_containers/food/snacks/poppypretzel,
								   /obj/item/weapon/reagent_containers/food/snacks/carrotfries,
								   /obj/item/weapon/reagent_containers/food/snacks/candiedapple,
								   /obj/item/weapon/reagent_containers/food/snacks/applepie,
								   /obj/item/weapon/reagent_containers/food/snacks/cherrypie,
								   /obj/item/weapon/reagent_containers/food/snacks/plumphelmetbiscuit,
								   /obj/item/weapon/reagent_containers/food/snacks/appletart,
								   /obj/item/weapon/reagent_containers/food/snacks/slice/carrotcake/filled,
								   /obj/item/weapon/reagent_containers/food/snacks/slice/cheesecake/filled,
								   /obj/item/weapon/reagent_containers/food/snacks/slice/plaincake/filled,
								   /obj/item/weapon/reagent_containers/food/snacks/slice/orangecake/filled,
								   /obj/item/weapon/reagent_containers/food/snacks/slice/limecake/filled,
								   /obj/item/weapon/reagent_containers/food/snacks/slice/lemoncake/filled,
								   /obj/item/weapon/reagent_containers/food/snacks/slice/chocolatecake/filled,
								   /obj/item/weapon/reagent_containers/food/snacks/slice/birthdaycake/filled,
								   /obj/item/weapon/reagent_containers/food/snacks/watermelonslice,
								   /obj/item/weapon/reagent_containers/food/snacks/slice/applecake/filled,
								   /obj/item/weapon/reagent_containers/food/snacks/slice/pumpkinpie/filled,
								   /obj/item/weapon/reagent_containers/food/snacks/skrellsnacks))

GLOBAL_LIST_INIT(lunchables_drinks_, list(/obj/item/weapon/reagent_containers/food/drinks/cans/cola,
								   /obj/item/weapon/reagent_containers/food/drinks/cans/waterbottle,
								   /obj/item/weapon/reagent_containers/food/drinks/cans/space_mountain_wind,
								   /obj/item/weapon/reagent_containers/food/drinks/cans/dr_gibb,
								   /obj/item/weapon/reagent_containers/food/drinks/cans/starkist,
								   /obj/item/weapon/reagent_containers/food/drinks/cans/space_up,
								   /obj/item/weapon/reagent_containers/food/drinks/cans/lemon_lime,
								   /obj/item/weapon/reagent_containers/food/drinks/cans/iced_tea,
								   /obj/item/weapon/reagent_containers/food/drinks/cans/grape_juice,
								   /obj/item/weapon/reagent_containers/food/drinks/cans/tonic,
								   /obj/item/weapon/reagent_containers/food/drinks/cans/sodawater))

// This default list is a bit different, it contains items we don't want
GLOBAL_LIST_INIT(lunchables_drink_reagents_, list(/datum/reagent/drink/nothing,
										   /datum/reagent/drink/doctor_delight,
										   /datum/reagent/drink/dry_ramen,
										   /datum/reagent/drink/hell_ramen,
										   /datum/reagent/drink/hot_ramen,
										   /datum/reagent/drink/nuka_cola,))

// This default list is a bit different, it contains items we don't want
GLOBAL_LIST_INIT(lunchables_ethanol_reagents_, list(/datum/reagent/ethanol/acid_spit,
											 /datum/reagent/ethanol/atomicbomb,
											 /datum/reagent/ethanol/beepsky_smash,
											 /datum/reagent/ethanol/coffee,
											 /datum/reagent/ethanol/hippies_delight,
											 /datum/reagent/ethanol/hooch,
											 /datum/reagent/ethanol/thirteenloko,
											 /datum/reagent/ethanol/manhattan_proj,
											 /datum/reagent/ethanol/neurotoxin,
											 /datum/reagent/ethanol/pwine,
											 /datum/reagent/ethanol/threemileisland,
											 /datum/reagent/ethanol/toxins_special))

/proc/lunchables_lunches()
	if(!(GLOB.lunchables_lunches_[GLOB.lunchables_lunches_[1]]))
		GLOB.lunchables_lunches_ = init_lunchable_list(GLOB.lunchables_lunches_)
	return GLOB.lunchables_lunches_

/proc/lunchables_snacks()
	if(!(GLOB.lunchables_snacks_[GLOB.lunchables_snacks_[1]]))
		GLOB.lunchables_snacks_ = init_lunchable_list(GLOB.lunchables_snacks_)
	return GLOB.lunchables_snacks_

/proc/lunchables_drinks()
	if(!(GLOB.lunchables_drinks_[GLOB.lunchables_drinks_[1]]))
		GLOB.lunchables_drinks_ = init_lunchable_list(GLOB.lunchables_drinks_)
	return GLOB.lunchables_drinks_

/proc/lunchables_drink_reagents()
	if(!(GLOB.lunchables_drink_reagents_[GLOB.lunchables_drink_reagents_[1]]))
		GLOB.lunchables_drink_reagents_ = init_lunchable_reagent_list(GLOB.lunchables_drink_reagents_, /datum/reagent/drink)
	return GLOB.lunchables_drink_reagents_

/proc/lunchables_ethanol_reagents()
	if(!(GLOB.lunchables_ethanol_reagents_[GLOB.lunchables_ethanol_reagents_[1]]))
		GLOB.lunchables_ethanol_reagents_ = init_lunchable_reagent_list(GLOB.lunchables_ethanol_reagents_, /datum/reagent/ethanol)
	return GLOB.lunchables_ethanol_reagents_

/proc/init_lunchable_list(var/list/lunches)
	. = list()
	for(var/lunch in lunches)
		var/obj/O = lunch
		.[initial(O.name)] = lunch
	return sortAssoc(.)

/proc/init_lunchable_reagent_list(var/list/banned_reagents, var/reagent_types)
	. = list()
	for(var/reagent_type in subtypesof(reagent_types))
		if(reagent_type in banned_reagents)
			continue
		var/datum/reagent/reagent = reagent_type
		.[initial(reagent.name)] = initial(reagent.id)
	return sortAssoc(.)

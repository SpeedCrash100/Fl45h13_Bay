GLOBAL_DATUM_INIT(assigned, /image, image('icons/Testing/Zone.dmi', icon_state = "assigned"))
GLOBAL_DATUM_INIT(created, /image, image('icons/Testing/Zone.dmi', icon_state = "created"))
GLOBAL_DATUM_INIT(merged, /image, image('icons/Testing/Zone.dmi', icon_state = "merged"))
GLOBAL_DATUM_INIT(invalid_zone, /image, image('icons/Testing/Zone.dmi', icon_state = "invalid"))
GLOBAL_DATUM_INIT(air_blocked, /image, image('icons/Testing/Zone.dmi', icon_state = "block"))
GLOBAL_DATUM_INIT(zone_blocked, /image, image('icons/Testing/Zone.dmi', icon_state = "zoneblock"))
GLOBAL_DATUM_INIT(blocked, /image, image('icons/Testing/Zone.dmi', icon_state = "fullblock"))
GLOBAL_DATUM_INIT(mark, /image, image('icons/Testing/Zone.dmi', icon_state = "mark"))

/connection_edge/var/dbg_out = 0

/turf/var/tmp/dbg_img
/turf/proc/dbg(image/img, d = 0)
	if(d > 0) img.dir = d
	overlays -= dbg_img
	overlays += img
	dbg_img = img

proc/soft_assert(thing,fail)
	if(!thing) message_admins(fail)
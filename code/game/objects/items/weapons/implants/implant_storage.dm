/obj/item/implant/storage
	name = "storage implant"
	desc = "Stores up to two big items in a bluespace pocket."
	icon_state = "storage"
	origin_tech = "materials=2;magnets=4;bluespace=5;syndicate=4"
	item_color = "r"

/obj/item/implant/storage/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = LoadComponent(/datum/component/storage/concrete)
	STR.max_items = 2
	STR.max_w_class = WEIGHT_CLASS_GIGANTIC
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.cant_hold = typecacheof(list(/obj/item/disk/nuclear))
	STR.silent = TRUE

/obj/item/implant/storage/activate()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.show_to(imp_in)

/obj/item/implant/storage/removed(source)
	if(..())
		GET_COMPONENT(STR, /datum/component/storage)
		STR.close_all()
		STR.do_quick_empty(get_turf(source))
		return TRUE

/obj/item/implant/storage/implant(mob/source)
	// allow for stacking storage implants
	var/obj/item/implant/storage/imp_e = locate(src.type) in source
	if(imp_e)
		GET_COMPONENT(STR, /datum/component/storage)
		GET_COMPONENT_FROM(EXISTING_STR, /datum/component/storage, imp_e)
		EXISTING_STR.max_items += STR.max_items
		EXISTING_STR.max_combined_w_class += STR.max_combined_w_class
		STR.do_quick_empty(imp_e) // load items from new implant into old implant

		EXISTING_STR.refresh_mob_views()
		for(var/mob/M in STR.can_see_contents())
			// transfer view from old inventory to new inventory
			STR.hide_from(M)
			EXISTING_STR.show_to(M)

		qdel(src)
		return 1

	return ..()

/obj/item/implant/storage/proc/get_contents() //Used for swiftly returning a list of the implant's contents i.e. for checking a theft objective's completion.
	return contents

/obj/item/implanter/storage
	name = "implanter (storage)"

/obj/item/implanter/storage/New()
	imp = new /obj/item/implant/storage(src)
	..()

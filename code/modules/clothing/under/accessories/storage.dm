/obj/item/clothing/accessory/storage
	name = "load bearing equipment"
	desc = "Used to hold things when you don't have enough hands."
	icon_state = "webbing"
	item_color = "webbing"
	slot = "utility"
	var/slots = 3
	actions_types = list(/datum/action/item_action/accessory/storage)
	w_class = WEIGHT_CLASS_NORMAL // so it doesn't fit in pockets

/obj/item/clothing/accessory/storage/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = LoadComponent(/datum/component/storage/concrete)
	STR.max_items = slots

/obj/item/clothing/accessory/storage/MouseDrop(obj/over_object as obj)
	if(has_suit)
		return
	return ..()

/obj/item/clothing/accessory/storage/emp_act(severity)
	for(var/atom/A in contents)
		A.emp_act(severity)
	..()

/obj/item/clothing/accessory/storage/hear_talk(mob/M, var/msg, verb, datum/language/speaking)
	for(var/atom/A in contents)
		A.hear_talk(M, msg, verb, speaking)
	..()

/obj/item/clothing/accessory/storage/hear_message(mob/M, var/msg, verb, datum/language/speaking)
	for(var/atom/A in contents)
		A.hear_message(M, msg)
	..()

/obj/item/clothing/accessory/storage/proc/return_inv()

	var/list/L = list(  )

	L += src.contents

	for(var/obj/item/storage/S in src)
		L += S.return_inv()
	for(var/obj/item/gift/G in src)
		L += G.gift
		if(istype(G.gift, /obj/item/storage))
			L += G.gift:return_inv()
	return L

/obj/item/clothing/accessory/storage/attack_self(mob/user as mob)
	GET_COMPONENT(STR, /datum/component/storage)
	if(has_suit)	//if we are part of a suit
		STR.open(user)
	else
		to_chat(user, "<span class='notice'>You empty [src].</span>")
		var/turf/T = get_turf(src)
		STR.close(user)
		STR.do_quick_empty(get_turf(user))
		src.add_fingerprint(user)

/obj/item/clothing/accessory/storage/webbing
	name = "webbing"
	desc = "Sturdy mess of synthcotton belts and buckles, ready to share your burden."
	icon_state = "webbing"
	item_color = "webbing"
	species_fit = list("Vox")
	sprite_sheets = list(
		"Vox" = 'icons/mob/species/vox/suit.dmi'
		)

/obj/item/clothing/accessory/storage/black_vest
	name = "black webbing vest"
	desc = "Robust black synthcotton vest with lots of pockets to hold whatever you need, but cannot hold in hands."
	icon_state = "vest_black"
	item_color = "vest_black"
	slots = 5

/obj/item/clothing/accessory/storage/brown_vest
	name = "brown webbing vest"
	desc = "Worn brownish synthcotton vest with lots of pockets to unload your hands."
	icon_state = "vest_brown"
	item_color = "vest_brown"
	slots = 5

/obj/item/clothing/accessory/storage/knifeharness
	name = "decorated harness"
	desc = "A heavily decorated harness of sinew and leather with two knife-loops."
	icon_state = "unathiharness2"
	item_color = "unathiharness2"
	slots = 2

/obj/item/clothing/accessory/storage/knifeharness/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_combined_w_class = 4
	STR.can_hold = typecacheof(list(/obj/item/hatchet/unathiknife, /obj/item/kitchen/knife))

/obj/item/clothing/accessory/storage/knifeharness/PopulateContents()
	new /obj/item/hatchet/unathiknife(src)
	new /obj/item/hatchet/unathiknife(src)

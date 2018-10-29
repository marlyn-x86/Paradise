/obj/item/storage/lockbox
	name = "lockbox"
	desc = "A locked box."
	icon_state = "lockbox+l"
	item_state = "syringe_kit"
	w_class = WEIGHT_CLASS_BULKY
	req_access = list(access_armory)
	var/locked = 1
	var/broken = 0
	var/icon_locked = "lockbox+l"
	var/icon_closed = "lockbox"
	var/icon_broken = "lockbox+b"

/obj/item/storage/lockbox/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_items = 4
	STR.max_combined_w_class = 14

/obj/item/storage/lockbox/attackby(obj/item/W as obj, mob/user as mob, params)
	if(istype(W, /obj/item/card/id) || istype(W, /obj/item/pda))
		if(broken)
			to_chat(user, "<span class='warning'>It appears to be broken.</span>")
			return
		if(check_access(W))
			locked = !locked
			if(locked)
				icon_state = icon_locked
				to_chat(user, "<span class='warning'>You lock \the [src]!</span>")
				return
			else
				icon_state = icon_closed
				to_chat(user, "<span class='warning'>You unlock \the [src]!</span>")
				origin_tech = null //wipe out any origin tech if it's unlocked in any way so you can't double-dip tech levels at R&D.
				return
		else
			to_chat(user, "<span class='warning'>Access denied.</span>")
			return
	else if((istype(W, /obj/item/card/emag) || (istype(W, /obj/item/melee/energy/blade)) && !broken))
		emag_act(user)
		return
	if(!locked)
		..()
	else
		to_chat(user, "<span class='warning'>It's locked!</span>")
	return


/obj/item/storage/lockbox/show_to(mob/user as mob)
	if(locked)
		to_chat(user, "<span class='warning'>It's locked!</span>")
	else
		..()
	return

/obj/item/storage/lockbox/can_be_inserted(obj/item/W as obj, stop_messages = 0)
	if(!locked)
		return ..()
	if(!stop_messages)
		to_chat(usr, "<span class='notice'>[src] is locked!</span>")
	return 0

/obj/item/storage/lockbox/emag_act(user as mob)
	if(!broken)
		broken = 1
		locked = 0
		desc = "It appears to be broken."
		icon_state = icon_broken
		to_chat(user, "<span class='notice'>You unlock \the [src].</span>")
		origin_tech = null //wipe out any origin tech if it's unlocked in any way so you can't double-dip tech levels at R&D.
		return

/obj/item/storage/lockbox/hear_talk(mob/living/M as mob, msg)

/obj/item/storage/lockbox/hear_message(mob/living/M as mob, msg)

/obj/item/storage/lockbox/large
	name = "Large lockbox"
	desc = "A large lockbox"

/obj/item/storage/lockbox/large/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.max_items = 1
	STR.max_combined_w_class = WEIGHT_CLASS_BULKY * 1

/obj/item/storage/lockbox/mindshield
	name = "Lockbox (Mindshield Implants)"
	req_access = list(access_security)

/obj/item/storage/lockbox/mindshield/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/implantcase/mindshield(src)
	new /obj/item/implanter/mindshield(src)


/obj/item/storage/lockbox/clusterbang
	name = "lockbox (clusterbang)"
	desc = "You have a bad feeling about opening this."
	req_access = list(access_security)

/obj/item/storage/lockbox/clusterbang/PopulateContents()
	new /obj/item/grenade/clusterbuster(src)


/obj/item/storage/lockbox/medal
	name = "medal box"
	desc = "A locked box used to store medals of honor."
	icon_state = "medalbox+l"
	item_state = "syringe_kit"
	w_class = WEIGHT_CLASS_NORMAL
	req_access = list(access_captain)
	icon_locked = "medalbox+l"
	icon_closed = "medalbox"
	icon_broken = "medalbox+b"

/obj/item/storage/lockbox/medal/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_SMALL
	STR.max_combined_w_class = 20
	STR.max_items = 12

/obj/item/storage/lockbox/medal/PopulateContents()
	new /obj/item/clothing/accessory/medal/gold/heroism(src)
	new /obj/item/clothing/accessory/medal/silver/security(src)
	new /obj/item/clothing/accessory/medal/silver/valor(src)
	new /obj/item/clothing/accessory/medal/nobel_science(src)
	new /obj/item/clothing/accessory/medal/bronze_heart(src)
	for(var/i in 1 to 3)
		new /obj/item/clothing/accessory/medal/conduct(src)
	new /obj/item/clothing/accessory/medal/gold/captain(src)

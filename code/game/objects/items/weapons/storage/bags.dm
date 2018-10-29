/*
 *	These absorb the functionality of the plant bag, ore satchel, etc.
 *	They use the use_to_pickup, quick_gather, and quick_empty functions
 *	that were already defined in weapon/storage, but which had been
 *	re-implemented in other classes.
 *
 *	Contains:
 *		Trash Bag
 *		Mining Satchel
 *		Plant Bag
 *		Sheet Snatcher
 *		Book Bag
 *		Tray
 *
 *	-Sayu
 */

//  Generic non-item
/obj/item/storage/bag
	slot_flags = SLOT_BELT

/obj/item/storage/bag/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.allow_quick_gather = TRUE
	STR.allow_quick_empty = TRUE
	STR.display_numerical_stacking = TRUE
	STR.click_gather = TRUE

// -----------------------------
//          Trash bag
// -----------------------------
/obj/item/storage/bag/trash
	name = "trash bag"
	desc = "It's the heavy-duty black polymer kind. Time to take out the trash!"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "trashbag"
	item_state = "trashbag"

	w_class = WEIGHT_CLASS_TINY

/obj/item/storage/bag/trash/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_SMALL
	STR.max_combined_w_class = 30
	STR.max_items = 30
	STR.cant_hold = typecacheof(list(/obj/item/disk/nuclear))

/obj/item/storage/bag/trash/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] puts the [name] over [user.p_their()] head and starts chomping at the insides! Disgusting!</span>")
	playsound(loc, 'sound/items/eatfood.ogg', 50, 1, -1)
	return (TOXLOSS)

/obj/item/storage/bag/trash/update_icon()
	if(contents.len == 0)
		w_class = WEIGHT_CLASS_TINY
		icon_state = "[initial(icon_state)]"
	else if(contents.len < 12)
		w_class = WEIGHT_CLASS_BULKY
		icon_state = "[initial(icon_state)]1"
	else if(contents.len < 21)
		w_class = WEIGHT_CLASS_BULKY
		icon_state = "[initial(icon_state)]2"
	else
		w_class = WEIGHT_CLASS_BULKY
		icon_state = "[initial(icon_state)]3"

/obj/item/storage/bag/trash/proc/janicart_insert(mob/user, obj/structure/janitorialcart/J)
	J.put_in_cart(src, user)
	J.mybag=src
	J.update_icon()

/obj/item/storage/bag/trash/cyborg

/obj/item/storage/bag/trash/cyborg/janicart_insert(mob/user, obj/structure/janitorialcart/J)
	return

/obj/item/storage/bag/trash/bluespace
	name = "trash bag of holding"
	desc = "The latest and greatest in custodial convenience, a trashbag that is capable of holding vast quantities of garbage."
	icon_state = "bluetrashbag"
	origin_tech = "materials=4;bluespace=4;engineering=4;plasmatech=3"
	flags_2 = NO_MAT_REDEMPTION_2

/obj/item/storage/bag/trash/bluespace/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_combined_w_class = 60
	STR.max_items = 60

// -----------------------------
//        Plastic Bag
// -----------------------------

/obj/item/storage/bag/plasticbag
	name = "plastic bag"
	desc = "It's a very flimsy, very noisy alternative to a bag."
	icon = 'icons/obj/trash.dmi'
	icon_state = "plasticbag"
	item_state = "plasticbag"
	slot_flags = SLOT_HEAD|SLOT_BELT
	throwforce = 0
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/bag/plasticbag/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.storage_slots = 7
	STR.max_w_class = WEIGHT_CLASS_SMALL
	STR.display_numerical_stacking = FALSE
	STR.cant_hold = list(/obj/item/disk/nuclear)

/obj/item/storage/bag/plasticbag/mob_can_equip(M as mob, slot)

	if(slot==slot_head && contents.len)
		to_chat(M, "<span class='warning'>You need to empty the bag first!</span>")
		return 0
	return ..()

/obj/item/storage/bag/plasticbag/equipped(var/mob/user, var/slot)
	if(slot==slot_head)
		GET_COMPONENT(STR, /datum/component/storage)
		STR.max_items = 0
		processing_objects.Add(src)

/obj/item/storage/bag/plasticbag/process()
	if(is_equipped())
		if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			if(H.get_item_by_slot(slot_head) == src)
				if(H.internal)
					return
				H.AdjustLoseBreath(1)
	else
		GET_COMPONENT(STR, /datum/component/storage)
		STR.max_items = 7
		processing_objects.Remove(src)
	return

// -----------------------------
//        Mining Satchel
// -----------------------------

/obj/item/storage/bag/ore
	name = "mining satchel"
	desc = "This little bugger can be used to store and transport ores."
	icon = 'icons/obj/mining.dmi'
	icon_state = "satchel"
	origin_tech = "engineering=2"
	slot_flags = SLOT_BELT | SLOT_POCKET
	w_class = WEIGHT_CLASS_NORMAL
	component_type = /datum/component/storage/concrete/stack
	var/spam_protection = FALSE //If this is TRUE, the holder won't receive any messages when they fail to pick up ore through crossing it
	var/datum/component/mobhook

/obj/item/storage/bag/ore/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage/concrete/stack)
	STR.allow_quick_empty = TRUE
	STR.can_hold = typecacheof(list(/obj/item/stack/ore))
	STR.max_w_class = WEIGHT_CLASS_HUGE
	STR.max_combined_stack_amount = 50

/obj/item/storage/bag/ore/equipped(mob/user)
	. = ..()
	if (mobhook && mobhook.parent != user)
		QDEL_NULL(mobhook)
	if (!mobhook)
		mobhook = user.AddComponent(/datum/component/redirect, list(COMSIG_MOVABLE_MOVED = CALLBACK(src, .proc/Pickup_ores, user)))

/obj/item/storage/bag/ore/dropped()
	. = ..()
	if (mobhook)
		QDEL_NULL(mobhook)

/obj/item/storage/bag/ore/proc/Pickup_ores(mob/living/user)
	var/show_message = FALSE
	var/obj/structure/ore_box/box
	var/turf/tile = user.loc
	if (!isturf(tile))
		return
	if (istype(user.pulling, /obj/structure/ore_box))
		box = user.pulling
	GET_COMPONENT(STR, /datum/component/storage)
	if(STR)
		for(var/A in tile)
			if (!is_type_in_typecache(A, STR.can_hold))
				continue
			var/atom/movable/AM = A
			if (box)
				AM.forceMove(box)
				show_message = TRUE
			else if(SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, A, user, TRUE))
				show_message = TRUE
			else
				if(!spam_protection)
					to_chat(user, "<span class='warning'>Your [name] is full and can't hold any more!</span>")
					spam_protection = TRUE
					continue
	if(show_message)
		playsound(user, "rustle", 50, TRUE)
		if (box)
			user.visible_message("<span class='notice'>[user] offloads the ores beneath [user.p_them()] into [box].</span>", \
			"<span class='notice'>You offload the ores beneath you into your [box].</span>")
		else
			user.visible_message("<span class='notice'>[user] scoops up the ores beneath [user.p_them()].</span>", \
				"<span class='notice'>You scoop up the ores beneath you with your [name].</span>")
	spam_protection = FALSE

/obj/item/storage/bag/ore/cyborg
	name = "cyborg mining satchel"
	flags = NODROP

/obj/item/storage/bag/ore/holding //miners, your messiah has arrived
	name = "mining satchel of holding"
	desc = "A revolution in convenience, this satchel allows for infinite ore storage. It's been outfitted with anti-malfunction safety measures."
	origin_tech = "bluespace=4;materials=3;engineering=3"
	icon_state = "satchel_bspace"

/obj/item/storage/bag/ore/holding/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage/concrete/stack)
	STR.max_items = INFINITY
	STR.max_combined_w_class = INFINITY
	STR.max_combined_stack_amount = INFINITY

/obj/item/storage/bag/ore/holding/cyborg
	name = "cyborg mining satchel of holding"
	flags = NODROP

// -----------------------------
//          Plant bag
// -----------------------------

/obj/item/storage/bag/plants
	name = "plant bag"
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "plantbag"
	w_class = WEIGHT_CLASS_TINY
	burn_state = FLAMMABLE

/obj/item/storage/bag/plants/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 100
	STR.max_items = 100
	STR.can_hold = typecacheof(list(/obj/item/reagent_containers/food/snacks/grown, /obj/item/reagent_containers/food/snacks/ash_flora, /obj/item/seeds, /obj/item/grown))

/obj/item/storage/bag/plants/portaseeder
	name = "portable seed extractor"
	desc = "For the enterprising botanist on the go. Less efficient than the stationary model, it creates one seed per plant."
	icon_state = "portaseeder"
	origin_tech = "biotech=3;engineering=2"

/obj/item/storage/bag/plants/portaseeder/verb/dissolve_contents()
	set name = "Activate Seed Extraction"
	set category = "Object"
	set desc = "Activate to convert your plants into plantable seeds."

	if(usr.incapacitated())
		return
	for(var/obj/item/O in contents)
		seedify(O, 1)
	GET_COMPONENT(STR, /datum/component/storage)
	STR.close_all()


// -----------------------------
//        Sheet Snatcher
// -----------------------------
// Because it stacks stacks, this doesn't operate normally.
// However, making it a storage/bag allows us to reuse existing code in some places. -Sayu

/obj/item/storage/bag/sheetsnatcher
	icon = 'icons/obj/mining.dmi'
	icon_state = "sheetsnatcher"
	name = "Sheet Snatcher"
	desc = "A patented Nanotrasen storage system designed for any kind of mineral sheet."
	w_class = WEIGHT_CLASS_NORMAL

	component_type = /datum/component/storage/concrete/stack

/obj/item/storage/bag/sheetsnatcher/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage/concrete/stack)
	STR.allow_quick_empty = TRUE
	STR.can_hold = typecacheof(list(/obj/item/stack/sheet))
	STR.cant_hold = typecacheof(list(/obj/item/stack/sheet/mineral/sandstone, /obj/item/stack/sheet/wood))
	STR.max_combined_stack_amount = 300

// -----------------------------
//    Sheet Snatcher (Cyborg)
// -----------------------------

/obj/item/storage/bag/sheetsnatcher/borg
	name = "Sheet Snatcher 9000"
	desc = ""

/obj/item/storage/bag/sheetsnatcher/borg/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage/concrete/stack)
	STR.max_combined_stack_amount = 500


// -----------------------------
//           Cash Bag
// -----------------------------

/obj/item/storage/bag/cash
	icon = 'icons/obj/storage.dmi'
	icon_state = "cashbag"
	name = "Cash bag"
	desc = "A bag for carrying lots of cash. It's got a big dollar sign printed on the front."
	w_class = WEIGHT_CLASS_TINY

/obj/item/storage/bag/cash/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_combined_w_class = 200
	STR.storage_slots = 50
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.can_hold = typecacheof(list(/obj/item/coin,/obj/item/stack/spacecash))

// -----------------------------
//           Book bag
// -----------------------------

/obj/item/storage/bag/books
	name = "book bag"
	desc = "A bag for books."
	icon = 'icons/obj/library.dmi'
	icon_state = "bookbag"
	w_class = WEIGHT_CLASS_BULKY //Bigger than a book because physics
	burn_state = FLAMMABLE

/obj/item/storage/bag/books/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 21
	STR.max_items = 7
	STR.display_numerical_stacking = FALSE
	STR.can_hold = typecacheof(list(/obj/item/book, /obj/item/storage/bible, /obj/item/spellbook, /obj/item/storage/bible))

/*
 * Trays - Agouri
 */
/obj/item/storage/bag/tray
	name = "tray"
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "tray"
	desc = "A metal tray to lay food on."
	force = 5
	throwforce = 10.0
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_BULKY
	flags = CONDUCT
	materials = list(MAT_METAL=3000)

/obj/item/storage/bag/tray/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.insert_preposition = "on"

/obj/item/storage/bag/tray/attack(mob/living/M as mob, mob/living/user as mob)
	..()
	// Drop all the things. All of them.
	var/list/obj/item/oldContents = contents.Copy()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.quick_empty()

	// Make each item scatter a bit
	for(var/obj/item/I in oldContents)
		spawn()
			for(var/i = 1, i <= rand(1,2), i++)
				if(I)
					step(I, pick(NORTH,SOUTH,EAST,WEST))
					sleep(rand(2,4))

	if(prob(50))
		playsound(M, 'sound/items/trayhit1.ogg', 50, 1)
	else
		playsound(M, 'sound/items/trayhit2.ogg', 50, 1)

	if(ishuman(M))
		if(prob(10))
			M.Weaken(2)

/obj/item/storage/bag/tray/proc/rebuild_overlays()
	overlays.Cut()
	for(var/obj/item/I in contents)
		overlays += image("icon" = I.icon, "icon_state" = I.icon_state, "layer" = -1)

/obj/item/storage/bag/tray/Entered()
	. = ..()
	rebuild_overlays()

/obj/item/storage/bag/tray/Exited()
	. = ..()
	rebuild_overlays()

/obj/item/storage/bag/tray/cyborg

/obj/item/storage/bag/tray/cyborg/afterattack(atom/target, mob/user as mob)
	if( isturf(target) || istype(target,/obj/structure/table) )
		var foundtable = istype(target,/obj/structure/table/)
		if( !foundtable ) //it must be a turf!
			for(var/obj/structure/table/T in target)
				foundtable = 1
				break

		var turf/dropspot
		if( !foundtable ) // don't unload things onto walls or other silly places.
			dropspot = user.loc
		else if( isturf(target) ) // they clicked on a turf with a table in it
			dropspot = target
		else					// they clicked on a table
			dropspot = target.loc

		overlays = null

		var droppedSomething = 0

		for(var/obj/item/I in contents)
			I.loc = dropspot
			contents.Remove(I)
			droppedSomething = 1
			if(!foundtable && isturf(dropspot))
				// if no table, presume that the person just shittily dropped the tray on the ground and made a mess everywhere!
				spawn()
					for(var/i = 1, i <= rand(1,2), i++)
						if(I)
							step(I, pick(NORTH,SOUTH,EAST,WEST))
							sleep(rand(2,4))
		if( droppedSomething )
			if( foundtable )
				user.visible_message("<span class='notice'>[user] unloads [user.p_their()] service tray.</span>")
			else
				user.visible_message("<span class='notice'>[user] drops all the items on [user.p_their()] tray.</span>")

	return ..()


/*
 *	Chemistry bag
 */

/obj/item/storage/bag/chemistry
	name = "chemistry bag"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bag"
	desc = "A bag for storing pills, patches, and bottles."
	w_class = WEIGHT_CLASS_TINY
	burn_state = FLAMMABLE

/obj/item/storage/bag/chemistry/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_combined_w_class = 200
	STR.max_items = 50
	STR.insert_preposition = "in"
	STR.can_hold = typecacheof(list(/obj/item/reagent_containers/food/pill, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/glass/bottle))
/*
 *  Biowaste bag (mostly for xenobiologists)
 */

/obj/item/storage/bag/bio
	name = "bio bag"
	icon = 'icons/obj/chemical.dmi'
	icon_state = "biobag"
	desc = "A bag for the safe transportation and disposal of biowaste and other biological materials."
	w_class = WEIGHT_CLASS_TINY
	burn_state = FLAMMABLE

/obj/item/storage/bag/bio/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_combined_w_class = 200
	STR.max_items = 25
	STR.insert_preposition = "in"
	STR.can_hold = typecacheof(list(/obj/item/slime_extract, /obj/item/reagent_containers/food/snacks/monkeycube, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/blood, /obj/item/reagent_containers/hypospray/autoinjector))

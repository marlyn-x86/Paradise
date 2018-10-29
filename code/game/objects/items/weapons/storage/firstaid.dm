/* First aid storage
 * Contains:
 *		First Aid Kits
 * 		Pill Bottles
 *		Dice Pack (in a pill bottle)
 */

/*
 * First Aid Kits
 */
/obj/item/storage/firstaid
	name = "first-aid kit"
	desc = "It's an emergency medical kit for those serious boo-boos."
	icon_state = "firstaid"
	throw_speed = 2
	throw_range = 8
	var/empty = FALSE
	req_one_access =list(access_medical, access_robotics) //Access and treatment are utilized for medbots.
	var/treatment_brute = "salglu_solution"
	var/treatment_oxy = "salbutamol"
	var/treatment_fire = "salglu_solution"
	var/treatment_tox = "charcoal"
	var/treatment_virus = "spaceacillin"
	var/med_bot_skin = null
	var/syndicate_aligned = FALSE

/obj/item/storage/firstaid/fire
	name = "fire first-aid kit"
	desc = "A medical kit that contains several medical patches and pills for treating burns. Contains one epinephrine syringe for emergency use and a health analyzer."
	icon_state = "ointment"
	item_state = "firstaid-ointment"
	med_bot_skin = "ointment"

/obj/item/storage/firstaid/fire/Initialize()
	. = ..()
	icon_state = pick("ointment","firefirstaid")

/obj/item/storage/firstaid/fire/PopulateContents()
	if(empty)
		return
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/food/pill/patch/silver_sulf(src)
	new /obj/item/healthanalyzer(src)
	new /obj/item/reagent_containers/hypospray/autoinjector(src)
	new /obj/item/reagent_containers/food/pill/salicylic(src)

/obj/item/storage/firstaid/fire/empty
	empty = TRUE

/obj/item/storage/firstaid/regular
	desc = "A general medical kit that contains medical patches for both brute damage and burn damage. Also contains an epinephrine syringe for emergency use and a health analyzer"
	icon_state = "firstaid"

/obj/item/storage/firstaid/regular/PopulateContents()
	if(empty)
		return
	for(var/i in 1 to 2)
		new /obj/item/reagent_containers/food/pill/patch/styptic(src)
	new /obj/item/reagent_containers/food/pill/salicylic(src)
	for(var/i in 1 to 2)
		new /obj/item/reagent_containers/food/pill/patch/silver_sulf(src)
	new /obj/item/healthanalyzer(src)
	new /obj/item/reagent_containers/hypospray/autoinjector(src)

/obj/item/storage/firstaid/toxin
	name = "toxin first aid kit"
	desc = "A medical kit designed to counter poisoning by common toxins. Contains three pills and syringes, and a health analyzer to determine the health of the patient."
	icon_state = "antitoxin"
	item_state = "firstaid-toxin"
	med_bot_skin = "tox"

/obj/item/storage/firstaid/toxin/Initialize()
	. = ..()

	icon_state = pick("antitoxin","antitoxfirstaid","antitoxfirstaid2","antitoxfirstaid3")

/obj/item/storage/firstaid/toxin/PopulateContents()
	if(empty)
		return

	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/syringe/charcoal(src)
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/food/pill/charcoal(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/firstaid/toxin/empty
	empty = TRUE

/obj/item/storage/firstaid/o2
	name = "oxygen deprivation first aid kit"
	desc = "A first aid kit that contains four pills of salbutamol, which is able to counter injuries caused by suffocation. Also contains a health analyzer to determine the health of the patient."
	icon_state = "o2"
	item_state = "firstaid-o2"
	med_bot_skin = "o2"

/obj/item/storage/firstaid/o2/PopulateContents()
	if(empty)
		return
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/food/pill/salbutamol(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/firstaid/o2/empty
	empty = TRUE

/obj/item/storage/firstaid/brute
	name = "brute trauma treatment kit"
	desc = "A medical kit that contains several medical patches and pills for treating brute injuries. Contains one epinephrine syringe for emergency use and a health analyzer."
	icon_state = "brute"
	item_state = "firstaid-brute"
	med_bot_skin = "brute"

/obj/item/storage/firstaid/brute/Initialize()
	. = ..()
	icon_state = pick("brute","brute2")

/obj/item/storage/firstaid/brute/PopulateContents()
	if(empty)
		return

	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/food/pill/patch/styptic(src)
	new /obj/item/healthanalyzer(src)
	new /obj/item/reagent_containers/hypospray/autoinjector(src)
	new /obj/item/stack/medical/bruise_pack(src)

/obj/item/storage/firstaid/brute/empty
	empty = TRUE

/obj/item/storage/firstaid/adv
	name = "advanced first-aid kit"
	desc = "Contains advanced medical treatments."
	icon_state = "advfirstaid"
	item_state = "firstaid-advanced"
	med_bot_skin = "adv"

/obj/item/storage/firstaid/adv/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/bruise_pack(src)
	for(var/i in 1 to 2)
		new /obj/item/stack/medical/bruise_pack/advanced(src)
	for(var/i in 1 to 2)
		new /obj/item/stack/medical/ointment/advanced(src)
	new /obj/item/reagent_containers/hypospray/autoinjector(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/firstaid/adv/empty
	empty = TRUE

/obj/item/storage/firstaid/tactical
	name = "first-aid kit"
	icon_state = "bezerk"
	desc = "I hope you've got insurance."
	treatment_oxy = "perfluorodecalin"
	treatment_brute = "bicaridine"
	treatment_fire = "kelotane"
	treatment_tox = "charcoal"
	req_one_access = list(access_syndicate)
	med_bot_skin = "bezerk"
	syndicate_aligned = TRUE

/obj/item/storage/firstaid/tactical/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/firstaid/tactical/PopulateContents()
	if(empty)
		return
	new /obj/item/reagent_containers/hypospray/combat(src)
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/food/pill/patch/synthflesh(src) // Because you ain't got no time to look at what damage dey taking yo
	new /obj/item/defibrillator/compact/combat/loaded(src)
	new /obj/item/clothing/glasses/hud/health/night(src)

/obj/item/storage/firstaid/tactical/empty
	empty = TRUE

/obj/item/storage/firstaid/surgery
	name = "field surgery kit"
	icon_state = "duffel-med"
	desc = "A kit for surgery in the field."

/obj/item/storage/firstaid/surgery/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.max_combined_w_class = 21
	STR.max_items = 10
	var/static/list/can_hold = typecacheof(list(
		/obj/item/roller,
		/obj/item/bonesetter,
		/obj/item/bonegel,
		/obj/item/scalpel,
		/obj/item/hemostat,
		/obj/item/cautery,
		/obj/item/retractor,
		/obj/item/FixOVein,
		/obj/item/surgicaldrill,
		/obj/item/circular_saw
	))
	STR.can_hold = can_hold

/obj/item/storage/firstaid/surgery/PopulateContents()
	new /obj/item/roller(src)
	new /obj/item/bonesetter(src)
	new /obj/item/bonegel(src)
	new /obj/item/scalpel(src)
	new /obj/item/hemostat(src)
	new /obj/item/cautery(src)
	new /obj/item/retractor(src)
	new /obj/item/FixOVein(src)
	new /obj/item/surgicaldrill(src)
	new /obj/item/circular_saw(src)

/*
 * Pill Bottles
 */
/obj/item/storage/pill_bottle
	name = "pill bottle"
	desc = "It's an airtight container for storing medication."
	icon_state = "pill_canister"
	icon = 'icons/obj/chemical.dmi'
	item_state = "contsolid"
	w_class = WEIGHT_CLASS_SMALL
	var/base_name = ""
	var/label_text = ""

/obj/item/storage/pill_bottle/Initialize()
	. = ..()
	base_name = name

/obj/item/storage/pill_bottle/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.click_gather = TRUE
	STR.allow_quick_gather = TRUE
	STR.display_numerical_stacking = TRUE
	STR.max_items = 14
	var/static/list/can_hold = typecacheof(list(/obj/item/reagent_containers/food/pill, /obj/item/dice, /obj/item/paper))
	STR.can_hold = can_hold

// do we even need this
/obj/item/storage/pill_bottle/MouseDrop(obj/over_object as obj) //Quick pillbottle fix. -Agouri
	if(ishuman(usr)) //Can monkeys even place items in the pocket slots? Leaving this in just in case~
		var/mob/M = usr
		if(!( istype(over_object, /obj/screen/inventory/hand) ))
			return ..()
		var/obj/screen/inventory/hand/hnd = over_object
		if((!( M.restrained() ) && !( M.stat ) /*&& M.pocket == src*/))
			switch(hnd.slot_id)
				if(slot_r_hand)
					M.unEquip(src)
					M.put_in_r_hand(src)
				if(slot_l_hand)
					M.unEquip(src)
					M.put_in_l_hand(src)
			src.add_fingerprint(usr)
			return
		if(over_object == usr && in_range(src, usr) || usr.contents.Find(src))
			if(usr.s_active)
				usr.s_active.close(usr)
			src.show_to(usr)
			return
	return

/obj/item/storage/pill_bottle/attackby(var/obj/item/I, mob/user as mob, params)
	if(istype(I, /obj/item/pen) || istype(I, /obj/item/flashlight/pen))
		var/tmp_label = sanitize(input(user, "Enter a label for [name]","Label",label_text))
		if(length(tmp_label) > MAX_NAME_LEN)
			to_chat(user, "<span class='warning'>The label can be at most [MAX_NAME_LEN] characters long.</span>")
		else
			to_chat(user, "<span class='notice'>You set the label to \"[tmp_label]\".</span>")
			label_text = tmp_label
			update_name_label()
	else
		..()

/obj/item/storage/pill_bottle/proc/update_name_label()
	if(label_text == "")
		name = base_name
	else
		name = "[base_name] ([label_text])"

/obj/item/storage/pill_bottle/charcoal
	name = "Pill bottle (Charcoal)"
	desc = "Contains pills used to counter toxins."

/obj/item/storage/pill_bottle/charcoal/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/food/pill/charcoal(src)


/obj/item/storage/pill_bottle/painkillers
	name = "Pill Bottle (Salicylic Acid)"
	desc = "Contains various pills for minor pain relief."

/obj/item/storage/pill_bottle/painkillers/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/food/pill/salicylic(src)

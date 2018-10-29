/obj/item/storage/belt
	name = "belt"
	desc = "Can hold various things."
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "utilitybelt"
	item_state = "utility"
	slot_flags = SLOT_BELT
	attack_verb = list("whipped", "lashed", "disciplined")
	max_integrity = 300
	var/use_item_overlays = 0 // Do we have overlays for items held inside the belt?


/obj/item/storage/belt/update_icon()
	if(use_item_overlays)
		overlays.Cut()
		for(var/obj/item/I in contents)
			overlays += "[I.name]"

	. = ..()

/obj/item/storage/belt/proc/can_use()
	return is_equipped()


/obj/item/storage/belt/MouseDrop(obj/over_object as obj, src_location, over_location)
	var/mob/M = usr
	if(!istype(over_object, /obj/screen))
		return ..()
	playsound(src.loc, "rustle", 50, 1, -5)
	if(!M.restrained() && !M.stat && can_use())
		switch(over_object.name)
			if("r_hand")
				M.unEquip(src)
				M.put_in_r_hand(src)
			if("l_hand")
				M.unEquip(src)
				M.put_in_l_hand(src)
		src.add_fingerprint(usr)
		return

/obj/item/storage/belt/deserialize(list/data)
	..()
	update_icon()

/obj/item/storage/belt/utility
	name = "tool-belt" //Carn: utility belt is nicer, but it bamboozles the text parsing.
	desc = "Can hold various tools."
	icon_state = "utilitybelt"
	item_state = "utility"
	use_item_overlays = 1

/obj/item/storage/belt/utility/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	var/static/list/can_hold = typecacheof(list(
		/obj/item/crowbar,
		/obj/item/screwdriver,
		/obj/item/weldingtool,
		/obj/item/wirecutters,
		/obj/item/wrench,
		/obj/item/multitool,
		/obj/item/flashlight,
		/obj/item/stack/cable_coil,
		/obj/item/t_scanner,
		/obj/item/analyzer,
		/obj/item/extinguisher/mini,
		/obj/item/holosign_creator))
	STR.can_hold = can_hold

/obj/item/storage/belt/utility/full/PopulateContents()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/wirecutters(src)
	new /obj/item/stack/cable_coil(src, 30, pick(COLOR_RED, COLOR_YELLOW, COLOR_ORANGE))

/obj/item/storage/belt/utility/full/multitool/PopulateContents()
	. = ..()
	new /obj/item/multitool(src)

/obj/item/storage/belt/utility/atmostech/PopulateContents()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/wirecutters(src)
	new /obj/item/t_scanner(src)
	new /obj/item/extinguisher/mini(src)

/obj/item/storage/belt/utility/chief
	name = "Chief Engineer's toolbelt"
	desc = "Holds tools, looks snazzy"
	icon_state = "utilitybelt_ce"
	item_state = "utility_ce"

/obj/item/storage/belt/utility/chief/full/PopulateContents()
	new /obj/item/screwdriver/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/weldingtool/experimental(src)//This can be changed if this is too much
	new /obj/item/multitool(src)
	new /obj/item/stack/cable_coil(src, 30, pick(COLOR_RED, COLOR_YELLOW, COLOR_ORANGE))
	new /obj/item/extinguisher/mini(src)
	new /obj/item/analyzer(src)
	//much roomier now that we've managed to remove two tools

/obj/item/storage/belt/medical
	name = "medical belt"
	desc = "Can hold various medical equipment."
	icon_state = "medicalbelt"
	item_state = "medical"
	use_item_overlays = 1

/obj/item/storage/belt/medical/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.click_gather = TRUE //Allow medical belt to pick up medicine
	var/static/list/can_hold = typecacheof(list(
		/obj/item/healthanalyzer,
		/obj/item/dnainjector,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/glass/beaker,
		/obj/item/reagent_containers/glass/bottle,
		/obj/item/reagent_containers/food/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/lighter/zippo,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/flashlight/pen,
		/obj/item/clothing/mask/surgical,
		/obj/item/clothing/gloves/color/latex,
        /obj/item/reagent_containers/hypospray/autoinjector,
        /obj/item/rad_laser,
		/obj/item/sensor_device,
		/obj/item/wrench/medical,
	))
	STR.can_hold = can_hold

/obj/item/storage/belt/medical/response_team/PopulateContents()
	new /obj/item/reagent_containers/food/pill/salbutamol(src)
	new /obj/item/reagent_containers/food/pill/salbutamol(src)
	new /obj/item/reagent_containers/food/pill/charcoal(src)
	new /obj/item/reagent_containers/food/pill/charcoal(src)
	new /obj/item/reagent_containers/food/pill/salicylic(src)
	new /obj/item/reagent_containers/food/pill/salicylic(src)
	new /obj/item/reagent_containers/food/pill/salicylic(src)


/obj/item/storage/belt/botany
	name = "botanist belt"
	desc = "Can hold various botanical supplies."
	icon_state = "botanybelt"
	item_state = "botany"
	use_item_overlays = 1

/obj/item/storage/belt/botany/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	var/static/list/can_hold = typecacheof(list(
		/obj/item/plant_analyzer,
		/obj/item/cultivator,
		/obj/item/hatchet,
		/obj/item/reagent_containers/glass/bottle,
//		/obj/item/reagent_containers/syringe,
//		/obj/item/reagent_containers/glass/beaker,
		/obj/item/lighter/zippo,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/shovel/spade,
		/obj/item/flashlight/pen,
		/obj/item/seeds,
		/obj/item/wirecutters,
		/obj/item/wrench,
	))
	STR.can_hold = can_hold


/obj/item/storage/belt/security
	name = "security belt"
	desc = "Can hold security gear like handcuffs and flashes."
	icon_state = "securitybelt"
	item_state = "security"//Could likely use a better one.
	use_item_overlays = 1

/obj/item/storage/belt/security/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	var/static/list/can_hold = list(
		/obj/item/grenade/flashbang,
		/obj/item/grenade/chem_grenade/teargas,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/flash,
		/obj/item/clothing/glasses,
		/obj/item/ammo_casing/shotgun,
		/obj/item/ammo_box,
		/obj/item/reagent_containers/food/snacks/donut,
		/obj/item/kitchen/knife/combat,
		/obj/item/melee/baton,
		/obj/item/melee/classic_baton,
		/obj/item/flashlight/seclite,
		/obj/item/holosign_creator/security,
		/obj/item/melee/classic_baton/telescopic,
		/obj/item/restraints/legcuffs/bola)
	STR.can_hold = can_hold
	STR.storage_slots = 5
	STR.max_w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/belt/security/sec/PopulateContents()
	new /obj/item/flashlight/seclite(src)

/obj/item/storage/belt/security/response_team/PopulateContents()
	new /obj/item/kitchen/knife/combat(src)
	new /obj/item/melee/baton/loaded(src)
	new /obj/item/flash(src)
	new /obj/item/melee/classic_baton/telescopic(src)
	new /obj/item/grenade/flashbang(src)

/obj/item/storage/belt/soulstone
	name = "soul stone belt"
	desc = "Designed for ease of access to the shards during a fight, as to not let a single enemy spirit slip away"
	icon_state = "soulstonebelt"
	item_state = "soulstonebelt"
	use_item_overlays = 1

/obj/item/storage/belt/soulstone/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.storage_slots = 6
	STR.can_hold = typecacheof(list(/obj/item/soulstone))

/obj/item/storage/belt/soulstone/full/PopulateContents()
	new /obj/item/soulstone(src)
	new /obj/item/soulstone(src)
	new /obj/item/soulstone(src)
	new /obj/item/soulstone(src)
	new /obj/item/soulstone(src)
	new /obj/item/soulstone(src)


/obj/item/storage/belt/champion
	name = "championship belt"
	desc = "Proves to the world that you are the strongest!"
	icon_state = "championbelt"
	item_state = "champion"
	materials = list(MAT_GOLD=400)

/obj/item/storage/belt/champion/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.storage_slots = 6
	STR.can_hold = typecacheof(list(
			/obj/item/clothing/mask/luchador,
		))

/obj/item/storage/belt/military
	name = "military belt"
	desc = "A syndicate belt designed to be used by boarding parties.  Its style is modelled after the hardsuits they wear."
	icon_state = "militarybelt"
	item_state = "military"

/obj/item/storage/belt/military/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/belt/military/abductor
	name = "agent belt"
	desc = "A belt used by abductor agents."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "belt"
	item_state = "security"

/obj/item/storage/belt/military/abductor/full/PopulateContents()
	new /obj/item/screwdriver/abductor(src)
	new /obj/item/wrench/abductor(src)
	new /obj/item/weldingtool/abductor(src)
	new /obj/item/crowbar/abductor(src)
	new /obj/item/wirecutters/abductor(src)
	new /obj/item/multitool/abductor(src)
	new /obj/item/stack/cable_coil(src, 30, COLOR_WHITE)

/obj/item/storage/belt/military/assault
	name = "assault belt"
	desc = "A tactical assault belt."
	icon_state = "assaultbelt"
	item_state = "assault"

/obj/item/storage/belt/military/assault/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.storage_slots = 6

/obj/item/storage/belt/janitor
	name = "janibelt"
	desc = "A belt used to hold most janitorial supplies."
	icon_state = "janibelt"
	item_state = "janibelt"
	use_item_overlays = 1

/obj/item/storage/belt/janitor/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.storage_slots = 6
	STR.max_w_class = WEIGHT_CLASS_BULKY // Set to this so the  light replacer can fit.
	var/static/list/can_hold = typecacheof(list(
		/obj/item/grenade/chem_grenade/cleaner,
		/obj/item/lightreplacer,
		/obj/item/flashlight,
		/obj/item/reagent_containers/spray,
		/obj/item/soap,
		/obj/item/holosign_creator
		))
	STR.can_hold = can_hold

/obj/item/storage/belt/janitor/full/PopulateContents()
	new /obj/item/lightreplacer(src)
	new /obj/item/holosign_creator(src)
	new /obj/item/reagent_containers/spray(src)
	new /obj/item/soap(src)
	new /obj/item/grenade/chem_grenade/cleaner(src)
	new /obj/item/grenade/chem_grenade/cleaner(src)

/obj/item/storage/belt/lazarus
	name = "trainer's belt"
	desc = "For the mining master, holds your lazarus capsules."
	icon_state = "lazarusbelt"
	item_state = "lazbelt"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/belt/lazarus/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_TINY
	STR.max_combined_w_class = 6
	STR.storage_slots = 6
	STR.can_hold = typecacheof(list(
		/obj/item/mobcapsule
		))
	AddComponent(/datum/component/redirect, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_EXITED), .proc/update_icon)

/obj/item/storage/belt/lazarus/update_icon()
	..()
	icon_state = "[initial(icon_state)]_[contents.len]"


/obj/item/storage/belt/bandolier
	name = "bandolier"
	desc = "A bandolier for holding shotgun ammunition."
	icon_state = "bandolier"
	item_state = "bandolier"

/obj/item/storage/belt/bandolier/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_items = 8
	STR.display_numerical_stacking = TRUE
	STR.can_hold = typecacheof(list(
		/obj/item/ammo_casing/shotgun
		))
	AddComponent(/datum/component/redirect, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_EXITED), .proc/update_icon)

/obj/item/storage/belt/bandolier/full/PopulateContents()
	for(var/i in 1 to 8)
		new /obj/item/ammo_casing/shotgun/beanbag(src)

/obj/item/storage/belt/bandolier/update_icon()
	..()
	icon_state = "[initial(icon_state)]_[contents.len]"


/obj/item/storage/belt/holster
	name = "shoulder holster"
	desc = "A holster to conceal a carried handgun. WARNING: Badasses only."
	icon_state = "holster"
	item_state = "holster"

/obj/item/storage/belt/holster/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_items = 1
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.can_hold = typecacheof(list(
		/obj/item/gun/projectile/automatic/pistol,
		/obj/item/gun/projectile/revolver/detective
		))

/obj/item/storage/belt/wands
	name = "wand belt"
	desc = "A belt designed to hold various rods of power. A veritable fanny pack of exotic magic."
	icon_state = "soulstonebelt"
	item_state = "soulstonebelt"
	use_item_overlays = 1

/obj/item/storage/belt/wands/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_items = 6
	STR.can_hold = typecacheof(list(
		/obj/item/gun/magic/wand
		))

/obj/item/storage/belt/wands/full/PopulateContents()
	new /obj/item/gun/magic/wand/death(src)
	new /obj/item/gun/magic/wand/resurrection(src)
	new /obj/item/gun/magic/wand/polymorph(src)
	new /obj/item/gun/magic/wand/teleport(src)
	new /obj/item/gun/magic/wand/door(src)
	new /obj/item/gun/magic/wand/fireball(src)

	for(var/obj/item/gun/magic/wand/W in contents) //All wands in this pack come in the best possible condition
		W.max_charges = initial(W.max_charges)
		W.charges = W.max_charges


/obj/item/storage/belt/fannypack
	name = "fannypack"
	desc = "A dorky fannypack for keeping small items in."
	icon_state = "fannypack_leather"
	item_state = "fannypack_leather"

/obj/item/storage/belt/fannypack/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_items = 3
	STR.max_w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/belt/fannypack/black
	name = "black fannypack"
	icon_state = "fannypack_black"
	item_state = "fannypack_black"

/obj/item/storage/belt/fannypack/red
	name = "red fannypack"
	icon_state = "fannypack_red"
	item_state = "fannypack_red"

/obj/item/storage/belt/fannypack/purple
	name = "purple fannypack"
	icon_state = "fannypack_purple"
	item_state = "fannypack_purple"

/obj/item/storage/belt/fannypack/blue
	name = "blue fannypack"
	icon_state = "fannypack_blue"
	item_state = "fannypack_blue"

/obj/item/storage/belt/fannypack/orange
	name = "orange fannypack"
	icon_state = "fannypack_orange"
	item_state = "fannypack_orange"

/obj/item/storage/belt/fannypack/white
	name = "white fannypack"
	icon_state = "fannypack_white"
	item_state = "fannypack_white"

/obj/item/storage/belt/fannypack/green
	name = "green fannypack"
	icon_state = "fannypack_green"
	item_state = "fannypack_green"

/obj/item/storage/belt/fannypack/pink
	name = "pink fannypack"
	icon_state = "fannypack_pink"
	item_state = "fannypack_pink"

/obj/item/storage/belt/fannypack/cyan
	name = "cyan fannypack"
	icon_state = "fannypack_cyan"
	item_state = "fannypack_cyan"

/obj/item/storage/belt/fannypack/yellow
	name = "yellow fannypack"
	icon_state = "fannypack_yellow"
	item_state = "fannypack_yellow"

/obj/item/storage/belt/rapier
	name = "rapier sheath"
	desc = "Can hold rapiers."
	icon_state = "sheath"
	item_state = "sheath"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/belt/rapier/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_items = 1
	STR.max_w_class = WEIGHT_CLASS_BULKY * 1
	STR.can_hold = typecacheof(list(/obj/item/melee/rapier))

/obj/item/storage/belt/rapier/update_icon()
	icon_state = "[initial(icon_state)]"
	item_state = "[initial(item_state)]"
	if(contents.len)
		icon_state = "[initial(icon_state)]-rapier"
		item_state = "[initial(item_state)]-rapier"
	if(isliving(loc))
		var/mob/living/L = loc
		L.update_inv_belt()
	..()

/obj/item/storage/belt/rapier/PopulateContents()
	new /obj/item/melee/rapier(src)

// -------------------------------------
//     Bluespace Belt
// -------------------------------------


/obj/item/storage/belt/bluespace
	name = "Belt of Holding"
	desc = "The greatest in pants-supporting technology."
	icon_state = "holdingbelt"
	item_state = "holdingbelt"
	w_class = WEIGHT_CLASS_BULKY
	origin_tech = "bluespace=5;materials=4;engineering=4;plasmatech=5"

/obj/item/storage/belt/bluespace/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_items = 14
	STR.max_w_class = WEIGHT_CLASS_SMALL
	STR.max_combined_w_class = 21 // = 14 * 1.5, not 14 * 2.  This is deliberate

/obj/item/storage/belt/bluespace/owlman
	name = "Owlman's utility belt"
	desc = "Sometimes people choose justice.  Sometimes, justice chooses you..."
	icon_state = "securitybelt"
	item_state = "security"
	origin_tech = "bluespace=5;materials=4;engineering=4;plasmatech=5"

	flags = NODROP
	var/smokecount = 0
	var/bolacount = 0
	var/cooldown = 0

/obj/item/storage/belt/bluespace/owlman/Initialize()
	. = ..()
	processing_objects.Add(src)
	cooldown = world.time

/obj/item/storage/belt/bluespace/owlman/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_items = 6
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 6 * WEIGHT_CLASS_NORMAL
	STR.allow_quick_empty = TRUE
	STR.can_hold = typecacheof(list(
		/obj/item/grenade/smokebomb,
		/obj/item/restraints/legcuffs/bola
		))

/obj/item/storage/belt/bluespace/owlman/PopulateContents()
	new /obj/item/grenade/smokebomb(src)
	new /obj/item/grenade/smokebomb(src)
	new /obj/item/grenade/smokebomb(src)
	new /obj/item/grenade/smokebomb(src)
	new /obj/item/restraints/legcuffs/bola(src)
	new /obj/item/restraints/legcuffs/bola(src)

/obj/item/storage/belt/bluespace/owlman/process()
	if(cooldown < world.time - 600)
		smokecount = 0
		var/obj/item/grenade/smokebomb/S
		for(S in src)
			smokecount++
		bolacount = 0
		var/obj/item/restraints/legcuffs/bola/B
		for(B in src)
			bolacount++
		if(smokecount < 4)
			while(smokecount < 4)
				new /obj/item/grenade/smokebomb(src)
				smokecount++
		if(bolacount < 2)
			while(bolacount < 2)
				new /obj/item/restraints/legcuffs/bola(src)
				bolacount++
		cooldown = world.time
		update_icon()
		GET_COMPONENT(STR, /datum/component/storage)
		STR.refresh_mob_views()

/obj/item/storage/belt/bluespace/attack(mob/M as mob, mob/user as mob, def_zone)
	return

/obj/item/storage/belt/bluespace/admin
	name = "Admin's Tool-belt"
	desc = "Holds everything for those that run everything."
	icon_state = "soulstonebelt"
	item_state = "soulstonebelt"
	w_class = 10 // permit holding other storage items

/obj/item/storage/belt/bluespace/admin/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_items = 28
	STR.max_w_class = 10
	STR.max_combined_w_class = 28 * 10

/obj/item/storage/belt/bluespace/admin/PopulateContents()
	new /obj/item/crowbar(src)
	new /obj/item/screwdriver(src)
	new /obj/item/weldingtool/hugetank(src)
	new /obj/item/wirecutters(src)
	new /obj/item/wrench(src)
	new /obj/item/multitool(src)
	new /obj/item/stack/cable_coil(src)

	new /obj/item/restraints/handcuffs(src)
	new /obj/item/dnainjector/xraymut(src)
	new /obj/item/dnainjector/firemut(src)
	new /obj/item/dnainjector/telemut(src)
	new /obj/item/dnainjector/hulkmut(src)
//		new /obj/item/spellbook(src) // for smoke effects, door openings, etc
//		new /obj/item/magic/spellbook(src)

//		new/obj/item/reagent_containers/hypospray/admin(src)

/obj/item/storage/belt/bluespace/sandbox
	name = "Sandbox Mode Toolbelt"
	desc = "Holds whatever, you can spawn your own damn stuff."
	w_class = 10 // permit holding other storage items

/obj/item/storage/belt/bluespace/sandbox/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_items = 28
	STR.max_w_class = 10
	STR.max_combined_w_class = 28 * 10

/obj/item/storage/belt/bluespace/sandbox/PopulateContents()
	new /obj/item/crowbar(src)
	new /obj/item/screwdriver(src)
	new /obj/item/weldingtool/hugetank(src)
	new /obj/item/wirecutters(src)
	new /obj/item/wrench(src)
	new /obj/item/multitool(src)
	new /obj/item/stack/cable_coil(src)

	new /obj/item/analyzer(src)
	new /obj/item/healthanalyzer(src)

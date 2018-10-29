/obj/item/storage/box/syndicate/PopulateContents()
	switch(pickweight(list("bloodyspai" = 1, "thief" = 1, "bond" = 1, "sabotage" = 1, "payday" = 1, "implant" = 1, "hacker" = 1, "darklord" = 1, "gadgets" = 1)))
		if("bloodyspai")
			new /obj/item/twohanded/garrote(src)
			new /obj/item/pinpointer/advpinpointer(src)
			new /obj/item/clothing/mask/gas/voice(src)
			new /obj/item/clothing/under/chameleon(src)
			new /obj/item/card/id/syndicate(src)
			new /obj/item/storage/box/syndie_kit/emp(src)
			new /obj/item/camera_bug(src)
			return

		if("thief")
			new /obj/item/gun/energy/kinetic_accelerator/crossbow(src)
			new /obj/item/chameleon(src)
			new /obj/item/clothing/gloves/color/black/thief(src)
			new /obj/item/card/id/syndicate(src)
			return

		if("bond")
			new /obj/item/gun/projectile/automatic/pistol(src)
			new /obj/item/suppressor(src)
			new /obj/item/ammo_box/magazine/m10mm/hp(src)
			new /obj/item/encryptionkey/syndicate(src)
			new /obj/item/storage/fancy/cigarettes/cigpack_syndicate(src)
			new /obj/item/implanter/krav_maga(src)
			new /obj/item/reagent_containers/food/drinks/drinkingglass/alliescocktail(src)
			return

		if("sabotage")
			new /obj/item/powersink(src)
			new /obj/item/grenade/syndieminibomb(src)
			new /obj/item/card/emag(src)
			new /obj/item/grenade/clusterbuster/n2o(src)
			new /obj/item/storage/box/syndie_kit/space(src)
			new /obj/item/clothing/gloves/color/yellow(src)
			new /obj/item/rcd/preloaded(src)
			return

		if("payday")
			new /obj/item/gun/projectile/revolver(src)
			new /obj/item/ammo_box/a357(src)
			new /obj/item/card/emag(src)
			new /obj/item/grenade/plastic/x4(src)
			new /obj/item/card/id/syndicate(src)
			new /obj/item/clothing/gloves/color/latex/nitrile(src)
			new /obj/item/clothing/mask/gas/clown_hat(src)
			return

		if("implant")
			new /obj/item/implanter/uplink(src)
			new /obj/item/implanter/adrenalin(src)
			new /obj/item/implanter/storage(src)
			new /obj/item/implanter/freedom(src)
			return

		if("hacker")
			new /obj/item/aiModule/syndicate(src)
			new /obj/item/encryptionkey/binary(src)
			new /obj/item/aiModule/toyAI(src)
			return

		if("darklord")
			new /obj/item/melee/energy/sword/saber/red(src)
			new /obj/item/melee/energy/sword/saber/red(src)
			new /obj/item/dnainjector/telemut/darkbundle(src)
			new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)
			new /obj/item/card/id/syndicate(src)
			return

		if("gadgets")
			new /obj/item/clothing/gloves/color/yellow/power(src)
			new /obj/item/pen/sleepy(src)
			new /obj/item/clothing/glasses/thermal/syndi(src)
			new /obj/item/flashlight/emp(src)
			new /obj/item/clothing/shoes/syndigaloshes(src)
			new /obj/item/stamp/chameleon(src)
			new /obj/item/multitool/ai_detect(src)
				return

/obj/item/storage/box/syndie_kit
	name = "Box"
	desc = "A sleek, sturdy box"
	icon_state = "box_of_doom"

/obj/item/storage/box/syndie_kit/space
	name = "Boxed Space Suit and Helmet"

/obj/item/storage/box/syndie_kit/space/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.can_hold = typecacheof(list(/obj/item/clothing/suit/space/syndicate/black/red, /obj/item/clothing/head/helmet/space/syndicate/black/red))

/obj/item/storage/box/syndie_kit/space/PopulateContents()
	new /obj/item/clothing/suit/space/syndicate/black/red(src)
	new /obj/item/clothing/head/helmet/space/syndicate/black/red(src)


/obj/item/storage/box/syndie_kit/hardsuit
	name = "Boxed Blood Red Suit and Helmet"

/obj/item/storage/box/syndie_kit/hardsuit/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.can_hold = typecacheof(list(/obj/item/clothing/suit/space/hardsuit/syndi, /obj/item/clothing/head/helmet/space/hardsuit/syndi))

/obj/item/storage/box/syndie_kit/hardsuit/PopulateContents()
	new /obj/item/clothing/suit/space/hardsuit/syndi(src)
	new /obj/item/clothing/head/helmet/space/hardsuit/syndi(src)


/obj/item/storage/box/syndie_kit/elite_hardsuit
	name = "Boxed Elite Syndicate Hardsuit and Helmet"

/obj/item/storage/box/syndie_kit/elite_hardsuit/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.can_hold = typecacheof(list(/obj/item/clothing/suit/space/hardsuit/syndi/elite, /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite))

/obj/item/storage/box/syndie_kit/elite_hardsuit/PopulateContents()
	new /obj/item/clothing/suit/space/hardsuit/syndi/elite(src)
	new /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite(src)


/obj/item/storage/box/syndie_kit/shielded_hardsuit
	name = "Boxed Shielded Syndicate Hardsuit and Helmet"

/obj/item/storage/box/syndie_kit/shielded_hardsuit/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.can_hold = typecacheof(list(/obj/item/clothing/suit/space/hardsuit/shielded/syndi, /obj/item/clothing/head/helmet/space/hardsuit/shielded/syndi))

/obj/item/storage/box/syndie_kit/shielded_hardsuit/New()
	new /obj/item/clothing/suit/space/hardsuit/shielded/syndi(src)
	new /obj/item/clothing/head/helmet/space/hardsuit/shielded/syndi(src)


/obj/item/storage/box/syndie_kit/conversion
	name = "box (CK)"

/obj/item/storage/box/syndie_kit/conversion/PopulateContents()
	new /obj/item/conversion_kit(src)
	new /obj/item/ammo_box/a357(src)

/obj/item/storage/box/syndie_kit/boolets
	name = "Shotgun shells"

/obj/item/storage/box/syndie_kit/boolets/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_casing/shotgun/fakebeanbag(src)

/obj/item/storage/box/syndie_kit/emp
	name = "boxed EMP kit"

/obj/item/storage/box/syndie_kit/emp/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/grenade/empgrenade(src)
	new /obj/item/implanter/emp(src)

/obj/item/storage/box/syndie_kit/throwing_weapons
	name = "boxed throwing kit"

/obj/item/storage/box/syndie_kit/throwing_weapons/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_combined_w_class = 16
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.can_hold = typecacheof(list(/obj/item/throwing_star, /obj/item/restraints/legcuffs/bola/tactical))

/obj/item/storage/box/syndie_kit/throwing_weapons/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/throwing_star(src)
	for(var/i in 1 to 2)
		new /obj/item/restraints/legcuffs/bola/tactical(src)


/obj/item/storage/box/syndie_kit/sarin
	name = "Sarin Gas Grenades"

/obj/item/storage/box/syndie_kit/sarin/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/grenade/chem_grenade/saringas(src)


/obj/item/storage/box/syndie_kit/bioterror
	name = "bioterror syringe box"

/obj/item/storage/box/syndie_kit/bioterror/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/syringe/bioterror(src)


/obj/item/storage/box/syndie_kit/caneshotgun
	name = "cane gun kit"

/obj/item/storage/box/syndie_kit/caneshotgun/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_casing/shotgun/dart/assassination(src)
	new /obj/item/gun/projectile/revolver/doublebarrel/improvised/cane(src)


/obj/item/storage/box/syndie_kit/atmosgasgrenades
	name = "Atmos Grenades"

/obj/item/storage/box/syndie_kit/atmosgasgrenades/PopulateContents()
	new /obj/item/grenade/clusterbuster/plasma(src)
	new /obj/item/grenade/clusterbuster/n2o(src)


/obj/item/storage/box/syndie_kit/missionary_set
	name = "Missionary Starter Kit"

/obj/item/storage/box/syndie_kit/missionary_set/PopulateContents()
	new /obj/item/nullrod/missionary_staff(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie/missionary_robe(src)
	var/obj/item/storage/bible/B = new /obj/item/storage/bible(src)
	if(prob(25))	//an omen of success to come?
		B.deity_name = "Success"
		B.icon_state = "greentext"
		B.item_state = "greentext"


/obj/item/storage/box/syndie_kit/cutouts
	name = "Fortified Artistic Box"

/obj/item/storage/box/syndie_kit/cutouts/PopulateContents()
	for(var/i in 1 to 3)
		new/obj/item/cardboard_cutout/adaptive(src)
	new/obj/item/toy/crayon/spraycan(src)


/obj/item/storage/box/syndie_kit/bonerepair
	name = "bone repair kit"
	desc = "A box containing one prototype field bone repair kit."

/obj/item/storage/box/syndie_kit/bonerepair/PopulateContents()
	new /obj/item/reagent_containers/hypospray/autoinjector/nanocalcium(src)
	var/obj/item/paper/P = new /obj/item/paper(src)
	P.name = "Bone repair guide"
	P.desc = "For when you want to safely get off Mr Bones' Wild Ride."
	P.info = {"
<font face="Verdana" color=black></font><font face="Verdana" color=black><center><B>Prototype Bone Repair Nanites</B><HR></center><BR><BR>

<B>Usage:</B> <BR><BR><BR>

<font size = "1">This is a highly experimental prototype chemical designed to repair damaged bones of soldiers in the field, use only as a last resort. The autoinjector contains prototype nanites bearing a calcium based payload. The nanites will simultaneously shut down body systems whilst aiding bone repair.<BR><BR><BR>Warning: Side effects can cause temporary paralysis, loss of co-ordination and sickness. <B>Do not use with any kind of stimulant or drugs. Serious damage can occur!</B><BR><BR><BR>

To apply, hold the injector a short distance away from the outer thigh before applying firmly to the skin surface. Bones should begin repair after a short time, during which you are advised to remain still. <BR><BR><BR><BR>After use you are advised to see a doctor at the next available opportunity. Mild scarring and tissue damage may occur after use. This is a prototype.</font><BR><HR></font>
	"}

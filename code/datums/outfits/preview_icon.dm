/datum/outfit/proc/generate_preview_overlay(icon/base_icon, backbag, fat)
	to_chat(world, "Blending in outfit!")
	blend_uniform(base_icon, fat)
	blend_shoes(base_icon)
	blend_gloves(base_icon)
	blend_mask(base_icon)
	blend_hat(base_icon)
	blend_suit(base_icon)
	blend_lhand(base_icon)
	blend_rhand(base_icon)

/datum/outfit/job/generate_preview_overlay(icon/base_icon, backbag, fat)
	..()
	blend_backbag(base_icon, backbag)

/datum/outfit/proc/blend_uniform(icon/base_icon, fat)
	if(uniform)
		var/icons_file = initial(uniform.icon)
		to_chat(world, "Blending Uniform!")
		if(fat)
			to_chat(world, "Uniform is fat!")
			icons_file = 'icons/mob/uniform_fat.dmi'
		base_icon.Blend(new /icon(icons_file, initial(uniform.icon_state)), ICON_OVERLAY)

/datum/outfit/proc/blend_shoes(icon/base_icon)
	if(shoes)
		base_icon.Blend(objpath_to_icon(shoes), ICON_UNDERLAY)

/datum/outfit/proc/blend_gloves(icon/base_icon)
	if(gloves)
		base_icon.Blend(objpath_to_icon(gloves), ICON_UNDERLAY)

/datum/outfit/proc/blend_mask(icon/base_icon)
	if(mask)
		base_icon.Blend(objpath_to_icon(mask), ICON_OVERLAY)

/datum/outfit/proc/blend_hat(icon/base_icon)
	if(head)
		base_icon.Blend(objpath_to_icon(head), ICON_OVERLAY)

/datum/outfit/proc/blend_suit(icon/base_icon)
	if(suit)
		base_icon.Blend(objpath_to_icon(suit), ICON_OVERLAY)

/datum/outfit/proc/blend_lhand(icon/base_icon)
	if(l_hand)
		base_icon.Blend(objpath_to_icon(l_hand), ICON_OVERLAY)

/datum/outfit/proc/blend_rhand(icon/base_icon)
	if(r_hand)
		base_icon.Blend(objpath_to_icon(r_hand), ICON_OVERLAY)

/datum/outfit/job/proc/blend_backbag(icon/base_icon, backbag)
	var/obj/item/BB
	switch(backbag)
		if(GBACKPACK)
			BB = /obj/item/weapon/storage/backpack
		if(GSATCHEL)
			BB = /obj/item/weapon/storage/backpack/satchel_norm
		if(GDUFFLEBAG)
			BB = /obj/item/weapon/storage/backpack/duffel
		if(LSATCHEL)
			BB = /obj/item/weapon/storage/backpack/satchel
		if(DSATCHEL)
			BB = satchel
		if(DDUFFLEBAG)
			BB = dufflebag
		else // DBACKPACK
			BB = backpack
	base_icon.Blend(objpath_to_icon(BB), ICON_OVERLAY)

/proc/objpath_to_icon(obj/item/path)
	return new /icon(initial(path.icon), initial(path.icon_state))

// Easter eggs go here
/datum/outfit/job/hop/blend_suit(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/suit.dmi', "ianshirt"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/bartender/blend_hat(icon/base_icon)
	if(prob(50))
		base_icon.Blend(new /icon('icons/mob/head.dmi', "tophat"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/botanist/blend_hat(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/head.dmi', "nymph"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/chef/blend_suit(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/suit.dmi', "apronchef"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/janitor/blend_suit(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/suit.dmi', "bio_janitor"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/librarian/blend_hat(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/head.dmi', "hairflower"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/quartermaster/blend_suit(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/suit.dmi', "poncho"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/cargotech/blend_hat(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/head.dmi', "flat_cap"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/miner/blend_hat(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/head.dmi', "bearpelt"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/lawyer/blend_suit(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/suit.dmi', "suitjacket_blue"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/chaplain/blend_suit(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/suit.dmi', "imperium_monk"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/research_director/blend_hat(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/head.dmi', "petehat"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/scientist/blend_hat(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/head.dmi', "metroid"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/chemist/blend_suit(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/suit.dmi', "labgreen"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/cmo/blend_suit(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/suit.dmi', "bio_cmo"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/doctor/blend_suit(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/suit.dmi', "surgeon"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/geneticist/blend_suit(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/suit.dmi', "monkeysuit"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/geneticist/blend_hat(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/head.dmi', "plaguedoctor"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/roboticist/blend_rhand(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/inhands/items_righthand.dmi', "toolbox_blue"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/captain/blend_hat(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/head.dmi', "centcomcaptain"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/hos/blend_hat(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/head.dmi', "beret_hos"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/warden/blend_shoes(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/feet.dmi', "slippers_worn"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/detective/blend_mask(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/mask.dmi', "cigaron"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/sec_officer/blend_hat(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/head.dmi', "beret_officer"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/chief_engineer/blend_rhand(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/inhands/items_righthand.dmi', "blueprints"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/station_engineer/blend_suit(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/suit.dmi', "hazard"), ICON_OVERLAY)
	else
		..()

/datum/outfit/job/atmos_tech/blend_suit(icon/base_icon)
	if(prob(1))
		base_icon.Blend(new /icon('icons/mob/suit.dmi', "firesuit"), ICON_OVERLAY)
	else
		..()

// AI/Cyborg dummy outfits
/datum/outfit/job/ai
	suit = /obj/item/clothing/suit/straight_jacket
	head = /obj/item/clothing/head/cardborg

/datum/outfit/job/cyborg
	suit = /obj/item/clothing/suit/cardborg
	head = /obj/item/clothing/head/cardborg

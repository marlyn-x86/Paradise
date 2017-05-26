/obj/structure/demonic_friend_beacon
	name = "Essence of friendship"
	desc = "Oh boy! Oh boy! A friend!"
	icon = 'icons/obj/items.dmi'
	icon_state = "empty_friend"
	var/obj/effect/proc_holder/spell/targeted/summon_friend/spell
	var/datum/mind/owner

/obj/structure/demonic_friend_beacon/initialize(datum/mind/owner_mind, obj/effect/proc_holder/spell/targeted/summon_friend/summoning_spell)
	..()
	owner = owner_mind
	var/area/A = get_area(src)
	notify_ghosts("\A friendship shell has been created in \the [A.name].", source = src, action=NOTIFY_ATTACK, flashwindow = FALSE)
	spell = summoning_spell

/obj/structure/demonic_friend_beacon/attack_ghost(mob/dead/observer/user)
	var/mob/living/carbon/human/H = makeBody()
	H.key = user.key
	spell.friend = H
	spell.charge_counter = spell.charge_max
	if(qdeleted(owner.current) || !owner.current || owner.current.stat == DEAD)
		to_chat(H, "<span class='userdanger'>Your owner is already dead!  You will soon perish.</span>")
		addtimer(H, "dust", 150) //Give em a few seconds as a mercy.
		return
	else
		to_chat(H, "<span class='warning'>You have been given a short reprieve from your durance in hell, to be [owner.name]'s friend.  Serve him well, for he can send you back to hell with a single thought.</span>")
	qdel(src)

/obj/structure/demonic_friend_beacon/proc/makeBody()
	var/mob/living/carbon/human/human/M = new(src.loc)
	M.real_name = "[owner.name]'s best friend"
	M.equip_to_slot_or_del(new /obj/item/clothing/under/assistantformal(M), slot_w_uniform)
	M.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup(M), slot_shoes)
	M.equip_to_slot_or_del(new /obj/item/device/radio/off(M), slot_r_store)
	M.equip_to_slot_or_del(new /obj/item/weapon/storage/backpack(M), slot_back)
	var/obj/item/weapon/card/id/W = new(M)
	W.name = "[owner.name]'s best friend's ID Card"
	W.access = list()
	W.assignment = "SuperFriend"
	W.registered_name = M.real_name
	M.equip_to_slot_or_del(W, slot_wear_id)
	return M

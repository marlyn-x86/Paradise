/obj/structure/respawner/newbody/demonic
	name = "Essence of friendship"
	desc = "Oh boy! Oh boy! A friend!"
	icon = 'icons/obj/items.dmi'
	icon_state = "empty_friend"
	var/obj/effect/proc_holder/spell/targeted/summon_friend/spell
	var/datum/mind/owner
	message = "Are you sure you want to become someone's 'best friend'?  You will lose all memories and be a new character."

/obj/structure/respawner/newbody/demonic/initialize(datum/mind/owner_mind, obj/effect/proc_holder/spell/targeted/summon_friend/summoning_spell)
	..()
	owner = owner_mind
	var/area/A = get_area(src)
	notify_ghosts("\A friendship shell has been created in \the [A.name].", source = src, action=NOTIFY_ATTACK, flashwindow = FALSE)
	spell = summoning_spell

/obj/structure/respawner/newbody/demonic/makeBody(mob/dead/observer/user)
	var/obj/effect/landmark/corpse/living/demonicFriend/spawner = new(src.loc)
	spawner.name = "[owner.name]'s best friend"
	var/mob/living/carbon/human/H = spawner.createCorpse()
	user.mind.transfer_to(H)
	spell.friend = H
	spell.charge_counter = spell.charge_max
	if(qdeleted(owner.current) || owner.current.stat != DEAD)
		to_chat(H, "<span class='userdanger'>Your owner is already dead!  You will soon perish.</span>")
		addtimer(H, "dust", 150) //Give em a few seconds as a mercy.
		return
	else
		to_chat(H, "<span class='warning'>You have been given a short reprieve from your durance in hell, to be [owner.name]'s friend.  Serve him well, for he can send you back to hell with a single thought.</span>")

/obj/item/dnascrambler
	name = "dna scrambler"
	desc = "An illegal genetic serum designed to randomize the user's identity."
	icon = 'icons/obj/hypo.dmi'
	item_state = "syringe_0"
	icon_state = "lepopen"
	var/used = null

	update_icon()
		if(used)
			icon_state = "lepopen0"
		else
			icon_state = "lepopen"

	attack(mob/M as mob, mob/user as mob)
		if(!M || !user)
			return

		if(!ishuman(M) || !ishuman(user))
			return

		if(used)
			return

		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(NO_DNA in H.species.species_traits)
				to_chat(user, "<span class='warning'>You failed to inject [M], as [M.p_they()] [M.p_have()] no DNA to scramble, nor flesh to inject.</span>")
				return

		if(M == user)
			user.visible_message("<span class='danger'>[user] injects [user.p_them()]self with [src]!</span>")
			injected(user, user)
		else
			user.visible_message("<span class='danger'>[user] is trying to inject [M] with [src]!</span>")
			if(do_mob(user,M,30))
				user.visible_message("<span class='danger'>[user] injects [M] with [src].</span>")
				injected(M, user)
			else
				to_chat(user, "<span class='warning'>You failed to inject [M].</span>")

	proc/injected(var/mob/living/carbon/human/target, var/mob/living/carbon/user)
		if(istype(target))
			var/mob/living/carbon/human/H = target
			H.scramble_appearance()
		target.update_icons()

		add_attack_logs(user, target, "injected with [src]")
		used = 1
		update_icon()
		name = "used " + name

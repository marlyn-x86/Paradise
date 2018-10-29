/obj/item/organ/internal/liver/skrell
	alcohol_intensity = 4

/obj/item/organ/internal/headpocket
	name = "headpocket"
	desc = "Allows Skrell to hide tiny objects within their head tentacles."
	icon_state = "skrell_headpocket"
	origin_tech = "biotech=2"
	w_class = WEIGHT_CLASS_TINY
	parent_organ = "head"
	slot = "headpocket"
	actions_types = list(/datum/action/item_action/organ_action/toggle)
	var/obj/item/storage/internal/pocket

/obj/item/organ/internal/headpocket/ComponentInitialize()
	. = ..()
	// Allow adjacency calculation to work properly
	loc = owner
	var/datum/component/storage/STR = AddComponent(/datum/component/storage)
	STR.max_items = 1
	// Fit only pocket sized items
	STR.max_w_class = WEIGHT_CLASS_SMALL
	STR.max_combined_w_class = 2

/obj/item/organ/internal/headpocket/on_life()
	..()
	var/obj/item/organ/external/head/head = owner.get_organ("head")
	if(contents.len && (owner.stunned || !findtextEx(head.h_style, "Tentacles")))
		owner.visible_message("<span class='notice'>Something falls from [owner]'s head!</span>",
													"<span class='notice'>Something falls from your head!</span>")
		empty_contents()

/obj/item/organ/internal/headpocket/ui_action_click()
	if(!loc)
		loc = owner
	GET_COMPONENT(STR, /datum/component/storage)
	STR.show_to(owner)

/obj/item/organ/internal/headpocket/on_owner_death()
	empty_contents()

/obj/item/organ/internal/headpocket/remove(mob/living/carbon/M, special = 0)
	if(!special)
		empty_contents()
	. = ..()

/obj/item/organ/internal/headpocket/proc/empty_contents()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.do_quick_empty(get_turf(owner))

/obj/item/organ/internal/headpocket/proc/get_contents()
	return contents

/obj/item/organ/internal/headpocket/emp_act(severity)
	for(var/atom/A in contents)
		A.emp_act(severity)
	..()

/obj/item/organ/internal/headpocket/hear_talk(mob/living/M as mob, msg)
	for(var/atom/A in contents)
		A.hear_talk(M, msg)
	..()

/obj/item/organ/internal/headpocket/hear_message(mob/living/M as mob, msg)
	for(var/atom/A in contents)
		A.hear_message(M, msg)
	..()

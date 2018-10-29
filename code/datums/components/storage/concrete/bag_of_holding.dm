/datum/component/storage/concrete/bag_of_holding
	allow_big_nesting = TRUE
	max_w_class = WEIGHT_CLASS_HUGE
	max_combined_w_class = 35
	cant_hold = typecacheof(list(/obj/item/storage/backpack/holding))

/datum/component/storage/concrete/bag_of_holding/handle_item_insertion(obj/item/W, prevent_warning = FALSE, mob/living/user)
	var/atom/A = parent
	if((istype(W, /obj/item/storage/backpack/holding) || count_by_type(W.GetAllContents(), /obj/item/storage/backpack/holding)))
		var/safety = alert(user, "Doing this will have extremely dire consequences for the station and its crew. Be sure you know what you're doing.", "Put in [A.name]?", "Abort", "Proceed")
		if(safety != "Proceed" || QDELETED(A) || QDELETED(W) || QDELETED(user) || A.CanUseTopic(user, physical_state) != STATUS_UPDATE)
			return
		user.visible_message("<span class='warning'>[user] grins as [user.p_they()] begin[user.p_s()] to put a Bag of Holding into a Bag of Holding!</span>", "<span class='warning'>You begin to put the Bag of Holding into the Bag of Holding!</span>")
		if(do_after(user, 30, target=src))
			parent.investigate_log("has become a singularity. Caused by [user.key]","singulo")
			user.visible_message("<span class='warning'>[user] erupts in evil laughter as [user.p_they()] put[user.p_s()] the Bag of Holding into another Bag of Holding!</span>", "<span class='warning'>You can't help but laugh wildly as you put the Bag of Holding into another Bag of Holding, complete darkness surrounding you.</span>","<span class='warning'> You hear the sound of scientific evil brewing! </span>")
			qdel(W)
			var/obj/singularity/singulo = new /obj/singularity(get_turf(user))
			singulo.energy = 300 //To give it a small boost
			message_admins("[key_name_admin(user)] detonated a bag of holding <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[parent.x];Y=[parent.y];Z=[parent.z]'>JMP</a>)")
			log_game("[key_name(user)] detonated a bag of holding")
			qdel(parent)
		else
			user.visible_message("After careful consideration, [user] has decided that putting a Bag of Holding inside another Bag of Holding would not yield the ideal outcome.","You come to the realization that this might not be the greatest idea.")
		return
	. = ..()

/obj/item/clothing/suit/storage
	var/pockets_type = /datum/component/storage/concrete/pockets

/obj/item/clothing/suit/storage/ComponentInitialize()
	. = ..()
	AddComponent(pockets_type)

/obj/item/clothing/suit/storage/ex_act(severity)
	for(var/atom/A in contents)
		A.ex_act(severity)
		CHECK_TICK
	. = ..()

/obj/item/clothing/suit/storage/emp_act(severity)
	if(!isliving(loc))
		for(var/atom/A in contents)
			A.emp_act(severity)
	. = ..()

/obj/item/clothing/suit/storage/hear_talk(mob/M, var/msg)
	for(var/atom/A in contents)
		A.hear_talk(M, msg)
	. = ..()

/obj/item/clothing/suit/storage/hear_message(mob/M, var/msg)
	for(var/atom/A in contents)
		A.hear_message(M, msg)
	. = ..()

/obj/item/clothing/suit/storage/proc/return_inv()

	var/list/L = list(  )

	L += src.contents

	for(var/obj/item/storage/S in src)
		L += S.return_inv()
	for(var/obj/item/gift/G in src)
		L += G.gift
		if(istype(G.gift, /obj/item/storage))
			L += G.gift:return_inv()
	return L

/obj/item/clothing/suit/storage/serialize()
	var/list/data = ..()
	var/list/content_list = list()
	GET_COMPONENT(STR, /datum/component/storage)
	data["content"] = content_list
	data["slots"] = STR.max_items
	data["max_w_class"] = STR.max_w_class
	data["max_c_w_class"] = STR.max_combined_w_class
	for(var/thing in contents)
		var/atom/movable/AM = thing
		// This code does not watch out for infinite loops
		// But then again a tesseract would destroy the server anyways
		// Also I wish I could just insert a list instead of it reading it the wrong way
		content_list.len++
		content_list[content_list.len] = AM.serialize()
	return data

//FIXME: Storage deserialization should be based on component in the future
/obj/item/clothing/suit/storage/deserialize(list/data)
	GET_COMPONENT(STR, /datum/component/storage)
	if(isnum(data["slots"]))
		STR.max_items = data["slots"]
	if(isnum(data["max_w_class"]))
		STR.max_w_class = data["max_w_class"]
	if(isnum(data["max_c_w_class"]))
		STR.max_combined_w_class = data["max_c_w_class"]
	for(var/thing in data["content"])
		if(islist(thing))
			list_to_object(thing, src)
		else if(thing == null)
			log_runtime(EXCEPTION("Null entry found in storage/deserialize."), src)
		else
			log_runtime(EXCEPTION("Non-list thing found in storage/deserialize."), src, list("Thing: [thing]"))

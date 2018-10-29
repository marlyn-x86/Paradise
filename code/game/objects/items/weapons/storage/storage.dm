// To clarify:
// For use_to_pickup and allow_quick_gather functionality,
// see item/attackby() (/game/objects/items.dm, params)
// Do not remove this functionality without good reason, cough reagent_containers cough.
// -Sayu

/obj/item/storage
	name = "storage"
	icon = 'icons/obj/storage.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	var/component_type = /datum/component/storage/concrete

/obj/item/storage/get_dumping_location(obj/item/storage/source,mob/user)
	return src

/obj/item/storage/Initialize()
	. = ..()
	PopulateContents()

/obj/item/storage/ComponentInitialize()
	AddComponent(component_type)

/obj/item/storage/AllowDrop()
	return TRUE

/* no contents_explosion port yet
/obj/item/storage/contents_explosion(severity, target)
	for(var/atom/A in contents)
		A.ex_act(severity, target)
		CHECK_TICK
*/

//Cyberboss says: "USE THIS TO FILL IT, NOT INITIALIZE OR NEW"

/obj/item/storage/proc/PopulateContents()

/obj/item/storage/emp_act(severity)
	if(!isliving(loc))
		for(var/obj/O in contents)
			O.emp_act(severity)
	..()

/obj/item/storage/hear_talk(mob/living/M as mob, msg)
	..()
	for(var/obj/O in contents)
		O.hear_talk(M, msg)

/obj/item/storage/hear_message(mob/living/M as mob, msg)
	..()
	for(var/obj/O in contents)
		O.hear_message(M, msg)

//Returns the storage depth of an atom. This is the number of storage items the atom is contained in before reaching toplevel (the area).
//Returns -1 if the atom was not found on container.
/atom/proc/storage_depth(atom/container)
	var/depth = 0
	var/atom/cur_atom = src

	while(cur_atom && !(cur_atom in container.contents))
		if(isarea(cur_atom))
			return -1
		if(istype(cur_atom.loc, /obj/item/storage))
			depth++
		cur_atom = cur_atom.loc

	if(!cur_atom)
		return -1	//inside something with a null loc.

	return depth

//Like storage depth, but returns the depth to the nearest turf
//Returns -1 if no top level turf (a loc was null somewhere, or a non-turf atom's loc was an area somehow).
/atom/proc/storage_depth_turf()
	var/depth = 0
	var/atom/cur_atom = src

	while(cur_atom && !isturf(cur_atom))
		if(isarea(cur_atom))
			return -1
		if(istype(cur_atom.loc, /obj/item/storage))
			depth++
		cur_atom = cur_atom.loc

	if(!cur_atom)
		return -1	//inside something with a null loc.

	return depth

/obj/item/storage/serialize()
	var data = ..()
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

/obj/item/storage/AllowDrop()
	return TRUE

//FIXME: Storage deserialization should be based on component in the future
/obj/item/storage/deserialize(list/data)
	GET_COMPONENT(STR, /datum/component/storage)
	if(isnum(data["slots"]))
		STR.max_items = data["slots"]
	if(isnum(data["max_w_class"]))
		STR.max_w_class = data["max_w_class"]
	if(isnum(data["max_c_w_class"]))
		STR.max_combined_w_class = data["max_c_w_class"]
	for(var/thing in contents)
		qdel(thing) // out with the old
	for(var/thing in data["content"])
		if(islist(thing))
			list_to_object(thing, src)
		else if(thing == null)
			log_runtime(EXCEPTION("Null entry found in storage/deserialize."), src)
		else
			log_runtime(EXCEPTION("Non-list thing found in storage/deserialize."), src, list("Thing: [thing]"))
	..()

/obj/item/storage/conveyor //Stores conveyor belts, click floor to make belt, use a conveyor switch on this to link all belts to that lever.
	name = "conveyor belt placer"
	desc = "This device facilitates the rapid deployment of conveyor belts."
	icon_state = "belt_placer"
	item_state = "belt_placer"
	w_class = WEIGHT_CLASS_BULKY //Because belts are large things, you know?
	flags = CONDUCT
	origin_tech = "engineering=1"

/obj/item/storage/conveyor/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.max_combined_w_class = 7 * WEIGHT_CLASS_BULKY //7 belts
	STR.allow_big_nesting = TRUE
	STR.click_gather = TRUE
	STR.display_numerical_stacking = TRUE
	STR.allow_quick_gather = TRUE
	STR.allow_quick_empty = TRUE
	STR.can_hold = typecacheof(list(/obj/item/conveyor_construct))

/obj/item/storage/conveyor/bluespace
	name = "bluespace conveyor belt placer"
	desc = "This device facilitates the rapid deployment of conveyor belts. It utilises bluespace in order to hold many more belts than its regular counterpart."
	icon_state = "bluespace_belt_placer"
	item_state = "bluespace_belt_placer"
	w_class = WEIGHT_CLASS_NORMAL
	origin_tech = "engineering=2;bluespace=1"

/obj/item/storage/conveyor/bluespace/ComponentInitialize()
	. = ..()
	GET_COMPONENT(STR, /datum/component/storage)
	STR.max_items = 50
	STR.max_combined_w_class = 50 * WEIGHT_CLASS_BULKY

/obj/item/storage/conveyor/attackby(obj/item/I, mob/user, params) //So we can link belts en masse
	if(istype(I, /obj/item/conveyor_switch_construct))
		var/obj/item/conveyor_switch_construct/S = I
		var/linked = FALSE //For nice message
		for(var/obj/item/conveyor_construct/C in src)
			C.id = S.id
			linked = TRUE
		if(linked)
			to_chat(user, "<span class='notice'>All belts in [src] linked with [S].</span>")
	else
		return ..()

/obj/item/storage/conveyor/afterattack(atom/A, mob/user, proximity)
	if(!proximity)
		return
	var/obj/item/conveyor_construct/C = locate() in src
	if(!C)
		to_chat(user, "<span class='notice'>There are no belts in [src].</span>")
	else
		C.afterattack(A, user, proximity)

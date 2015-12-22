// A special pen for service droids. Can be toggled to switch between normal writing mode, and paper rename mode
// Allows service droids to rename paper items.

/obj/item/weapon/pen/robopen
	desc = "A black ink printing attachment with a paper naming mode."
	name = "Printing Pen"
	var/mode = 1

/obj/item/weapon/pen/robopen/attack_self(mob/user as mob)

	var/choice = input("Would you like to change colour or mode?") as null|anything in list("Colour","Mode")
	if(!choice) return

	playsound(src.loc, 'sound/effects/pop.ogg', 50, 0)

	switch(choice)

		if("Colour")
			var/newcolour = input("Which colour would you like to use?") as null|anything in list("black","blue","red","green","yellow")
			if(newcolour) colour = newcolour

		if("Mode")
			if (mode == 1)
				mode = 2
			else
				mode = 1
			user << "Changed printing mode to '[mode == 2 ? "Rename Paper" : "Write Paper"]'"

	return

// Copied over from paper's rename verb
// see code\modules\paperwork\paper.dm line 62

/obj/item/weapon/pen/robopen/proc/RenamePaper(mob/user as mob,obj/paper as obj)
	if ( !user || !paper )
		return
	var/n_name = input(user, "What would you like to label the paper?", "Paper Labelling", null)  as text
	if ( !user || !paper )
		return

	n_name = copytext(n_name, 1, 32)
	if(( get_dist(user,paper) <= 1  && user.stat == 0))
		paper.name = "paper[(n_name ? text("- '[n_name]'") : null)]"
	add_fingerprint(user)
	return

//TODO: Add prewritten forms to dispense when you work out a good way to store the strings.
/obj/item/weapon/form_printer
	//name = "paperwork printer"
	name = "paper dispenser"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "paper_bin1"
	item_state = "sheet-metal"

/obj/item/weapon/form_printer/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	return

/obj/item/weapon/form_printer/afterattack(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, flag, params)

	if(!target || !flag)
		return

	if(istype(target,/obj/structure/table))
		deploy_paper(get_turf(target))

/obj/item/weapon/form_printer/attack_self(mob/user as mob)
	deploy_paper(get_turf(src))

/obj/item/weapon/form_printer/proc/deploy_paper(var/turf/T)
	T.visible_message("\blue \The [src.loc] dispenses a sheet of crisp white paper.")
	new /obj/item/weapon/paper(T)


//Personal shielding for the combat module.
/obj/item/borg
	var/powerneeded // Percentage of power remaining required to run item

/obj/item/borg/combat/shield
	name = "personal shielding"
	desc = "A powerful experimental module that turns aside or absorbs incoming attacks at the cost of charge."
	icon = 'icons/obj/decals.dmi'
	icon_state = "shock"
	powerneeded = 25
	var/shield_level = 0.5 //Percentage of damage absorbed by the shield.

/obj/item/borg/combat/shield/verb/set_shield_level()
	set name = "Set shield level"
	set category = "Object"
	set src in range(0)

	var/N = input("How much damage should the shield absorb?") in list("5","10","25","50","75","100")
	if (N)
		shield_level = text2num(N)/100

/obj/item/borg/combat/mobility
	name = "mobility module"
	desc = "By retracting limbs and tucking in its head, a combat android can roll at high speeds."
	icon = 'icons/obj/decals.dmi'
	icon_state = "shock"
	powerneeded = 25

/*
A general-purpose stack item that can be used to let cyborgs and drones pick up items of a type they've
exhausted their entire supply of. Also forms a handy base item for a recharging stack.
*/
/obj/item/borg/robot_stack
	var/obj/item/stack/stack = null
	var/stacktype = ""
	var/refill_cap // This is the limit for standard cyborg recharging. Collecting extra items can bring you above this.

/obj/item/borg/robot_stack/New(var/loc)
	stack = new stacktype(loc, refill_cap)
	icon_state = stack.icon_state
	name = stack.name
	desc = stack.desc


/obj/item/borg/robot_stack/attack(mob/living/M as mob, mob/user as mob)
	if (stack)
		return stack.attack(M, user)
	// Otherwise, we've exhausted our supply, we'll handle replenishment in the afterattack.
	else
		user << "<span class='danger'>\You've exhausted your supply of [stack.name]!</span>"


/obj/item/borg/robot_stack/attack_self(mob/user as mob)
	if (stack)
		return stack.attack_self(mob/user as mob)

/obj/item/borg/robot_stack/afterattack(atom/target as obj, mob/living/user as mob|obj, proximity, params)
	if (!stack && istype(target, stacktype))
		target.loc = src
		stack = target

	if (stack)
		stack.update_icon()
		icon_state = stack.icon_state

// Will resupply the stack by [count] items
/obj/item/borg/robot_stack/replenish(var/count)
	if (stack)
		stack.amount = min(stack.amount + count, refill_cap)
	else
		stack = new stacktype(src, min(count, refill_cap))
	stack.update_icon()
	if (stack.amount == refill_cap)
		// There should probably be a better message here
		M << "<span class='notics'>\System notice: [stack.name] fully restocked.</span>"

/* A handy stack handler for items that should replenish while in a cyborg's grasp
I intend for this to only be for items without a severe effect on the world.
Things this would be used for:
* Nanopaste
* Trauma/burn kits

Things this would NOT be used for:
* Material sheets

*/
/obj/item/borg/robot_stack/recharging
	name = "A recharging stack"
	desc = "If you're seeing this, something went very, very wronger."
	var/charge_tick = 0
	var/charge_cost
	var/recharge_time

/obj/item/borg/robot_stack/recharging/process()
	charge_tick++
	if (charge_tick < recharge_time) return
	charge_tick = 0

	if (isrobot(src.loc))
		var/mob/living/silicon/robot = src.loc
		if (R && R.cell)
			if (stack.amount < refill_cap && R.cell.use(charge_cost))
				replenish(1)

// Special item stacks for the medical borg
/obj/item/stack/nanopaste/mediborg
	name = "medical nanopaste"
	desc = "A tube of paste containing swarms of repair nanites. Very effective in repairing robotic machinery. This particular tube is engineered specifically for medical situations."
	origin_tech = null

/obj/item/stack/nanopaste/mediborg/attack(mob/living/M as mob, mob/usr as mob)
	if (istype(M, /mob/living/silicon/robot))
		user << "<span class='danger'>This tube doesn't work on cyborgs!</span>"
		return 1
	return ..()

/obj/item/robot_stack/recharging/mediborg_nanopaste
	stacktype = /obj/item/stack/nanopaste/mediborg
	charge_cost = 150 // A fuzzy value for now.
	recharge_time = 150
	refill_cap = 5

/obj/item/robot_stack/recharging/mediborg_trauma
	stacktype = /obj/item/stack/medical/advanced/bruise_pack
	charge_cost = 150
	recharge_time = 150
	refill_cap = 5

/obj/item/robot_stack/recharging/mediborg_burn
	stacktype = /obj/item/stack/medical/advanced/ointment
	charge_cost = 150
	recharge_time = 150
	refill_cap = 5

/mob/living/silicon/gib()
	death(1)
	var/atom/movable/overlay/animation = null
	notransform = 1
	canmove = 0
	icon = null
	invisibility = 101

	animation = new(loc)
	animation.icon_state = "blank"
	animation.icon = 'icons/mob/mob.dmi'
	animation.master = src

	playsound(src.loc, 'sound/goonstation/effects/robogib.ogg', 50, 1)

//	flick("gibbed-r", animation)
	robogibs(loc)

	dead_mob_list -= src
	spawn(15)
		if(animation)	qdel(animation)
		if(src)			qdel(src)

/mob/living/silicon/dust()
	death(1)
	notransform = 1
	canmove = 0
	icon = null
	invisibility = 101
	dust_animation()
	dead_mob_list -= src
	spawn(15)
		if(src)
			qdel(src)

/mob/living/silicon/dust_animation()
	var/atom/movable/overlay/animation = null

	animation = new(loc)
	animation.icon_state = "blank"
	animation.icon = 'icons/mob/mob.dmi'
	animation.master = src
	spawn(15)
		if(animation)	qdel(animation)

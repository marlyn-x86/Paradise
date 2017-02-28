/datum/preferences
	//The mob should have a gender you want before running this proc. Will run fine without H
/datum/preferences/proc/random_character(gender_override)
	var/datum/robolimb/robohead
	if(species == "Machine")
		var/head_model = "[!rlimb_data["head"] ? "Morpheus Cyberkinetics" : rlimb_data["head"]]"
		robohead = all_robolimbs[head_model]
	if(gender_override)
		gender = gender_override
	else
		gender = pick(MALE, FEMALE)
	underwear = random_underwear(gender, species)
	undershirt = random_undershirt(gender, species)
	socks = random_socks(gender, species)
	if(species == "Vulpkanin")
		body_accessory = random_body_accessory(species)
		if(body_accessory == "None") //Required to prevent a bug where the information/icons in the character preferences screen wouldn't update despite the data being changed.
			body_accessory = null
	if(species in list("Human", "Drask", "Vox"))
		s_tone = random_skin_tone(species)
	h_style = random_hair_style(gender, species, robohead)
	f_style = random_facial_hair_style(gender, species, robohead)
	if(species in list("Human", "Unathi", "Tajaran", "Skrell", "Machine", "Vulpkanin", "Vox"))
		randomize_hair_color("hair")
		randomize_hair_color("facial")
	if(species in list("Unathi", "Vulpkanin", "Tajaran", "Machine"))
		ha_style = random_head_accessory(species)
		var/list/colours = randomize_skin_color(1)
		r_headacc = colours["red"]
		g_headacc = colours["green"]
		b_headacc = colours["blue"]
	if(species in list("Machine", "Tajaran", "Unathi", "Vulpkanin"))
		m_styles["head"] = random_marking_style("head", species, robohead, null, alt_head)
		var/list/colours = randomize_skin_color(1)
		m_colours["head"] = rgb(colours["red"], colours["green"], colours["blue"])
	if(species in list("Human", "Unathi", "Grey", "Vulpkanin", "Tajaran", "Skrell", "Vox", "Drask"))
		m_styles["body"] = random_marking_style("body", species)
		var/list/colours = randomize_skin_color(1)
		m_colours["body"] = rgb(colours["red"], colours["green"], colours["blue"])
	if(species in list("Vox", "Vulpkanin")) //Species with tail markings.
		m_styles["tail"] = random_marking_style("tail", species, null, body_accessory)
		var/list/colours = randomize_skin_color(1)
		m_colours["tail"] = rgb(colours["red"], colours["green"], colours["blue"])
	if(species != "Machine")
		randomize_eyes_color()
	if(species in list("Unathi", "Tajaran", "Skrell", "Vulpkanin"))
		randomize_skin_color()
	backbag = 2
	age = rand(AGE_MIN, AGE_MAX)


/datum/preferences/proc/randomize_hair_color(var/target = "hair")
	if(prob (75) && target == "facial") // Chance to inherit hair color
		r_facial = r_hair
		g_facial = g_hair
		b_facial = b_hair
		return

	var/red
	var/green
	var/blue

	var/col = pick ("blonde", "black", "chestnut", "copper", "brown", "wheat", "old", "punk")
	switch(col)
		if("blonde")
			red = 255
			green = 255
			blue = 0
		if("black")
			red = 0
			green = 0
			blue = 0
		if("chestnut")
			red = 153
			green = 102
			blue = 51
		if("copper")
			red = 255
			green = 153
			blue = 0
		if("brown")
			red = 102
			green = 51
			blue = 0
		if("wheat")
			red = 255
			green = 255
			blue = 153
		if("old")
			red = rand (100, 255)
			green = red
			blue = red
		if("punk")
			red = rand (0, 255)
			green = rand (0, 255)
			blue = rand (0, 255)

	red = max(min(red + rand (-25, 25), 255), 0)
	green = max(min(green + rand (-25, 25), 255), 0)
	blue = max(min(blue + rand (-25, 25), 255), 0)

	switch(target)
		if("hair")
			r_hair = red
			g_hair = green
			b_hair = blue
		if("facial")
			r_facial = red
			g_facial = green
			b_facial = blue

/datum/preferences/proc/randomize_eyes_color()
	var/red
	var/green
	var/blue

	var/col = pick ("black", "grey", "brown", "chestnut", "blue", "lightblue", "green", "albino")
	switch(col)
		if("black")
			red = 0
			green = 0
			blue = 0
		if("grey")
			red = rand (100, 200)
			green = red
			blue = red
		if("brown")
			red = 102
			green = 51
			blue = 0
		if("chestnut")
			red = 153
			green = 102
			blue = 0
		if("blue")
			red = 51
			green = 102
			blue = 204
		if("lightblue")
			red = 102
			green = 204
			blue = 255
		if("green")
			red = 0
			green = 102
			blue = 0
		if("albino")
			red = rand (200, 255)
			green = rand (0, 150)
			blue = rand (0, 150)

	red = max(min(red + rand (-25, 25), 255), 0)
	green = max(min(green + rand (-25, 25), 255), 0)
	blue = max(min(blue + rand (-25, 25), 255), 0)

	r_eyes = red
	g_eyes = green
	b_eyes = blue

/datum/preferences/proc/randomize_skin_color(var/pass_to_list)
	var/red
	var/green
	var/blue

	var/col = pick ("black", "grey", "brown", "chestnut", "blue", "lightblue", "green", "albino")
	switch(col)
		if("black")
			red = 0
			green = 0
			blue = 0
		if("grey")
			red = rand (100, 200)
			green = red
			blue = red
		if("brown")
			red = 102
			green = 51
			blue = 0
		if("chestnut")
			red = 153
			green = 102
			blue = 0
		if("blue")
			red = 51
			green = 102
			blue = 204
		if("lightblue")
			red = 102
			green = 204
			blue = 255
		if("green")
			red = 0
			green = 102
			blue = 0
		if("albino")
			red = rand (200, 255)
			green = rand (0, 150)
			blue = rand (0, 150)

	red = max(min(red + rand (-25, 25), 255), 0)
	green = max(min(green + rand (-25, 25), 255), 0)
	blue = max(min(blue + rand (-25, 25), 255), 0)

	if(pass_to_list)
		var/list/colours = list(
			"red" = red,
			"blue" = blue,
			"green" = green
			)
		return colours
	else
		r_skin = red
		g_skin = green
		b_skin = blue

/datum/preferences/proc/blend_backpack(var/icon/clothes_s,var/backbag,var/satchel,var/backpack="backpack")
	switch(backbag)
		if(GBACKPACK, DBACKPACK)
			clothes_s.Blend(new /icon('icons/mob/back.dmi', backpack), ICON_OVERLAY)
		if(GSATCHEL, DSATCHEL)
			clothes_s.Blend(new /icon('icons/mob/back.dmi', satchel), ICON_OVERLAY)
		if(LSATCHEL)
			clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel"), ICON_OVERLAY)
	return clothes_s

/datum/preferences/proc/update_preview_icon(var/for_observer=0)		//seriously. This is horrendous.
	qdel(preview_icon_front)
	qdel(preview_icon_side)
	qdel(preview_icon)

	var/g = "m"
	if(gender == FEMALE)	g = "f"

	var/icon/icobase
	var/datum/species/current_species = all_species[species]

	//Icon-based species colour.
	var/coloured_tail
	if(current_species)
		if(current_species.bodyflags & HAS_ICON_SKIN_TONE) //Handling species-specific icon-based skin tones by flagged race.
			var/mob/living/carbon/human/H = new
			H.species = current_species
			H.s_tone = s_tone
			H.species.updatespeciescolor(H, 0) //The mob's species wasn't set, so it's almost certainly different than the character's species at the moment. Thus, we need to be owner-insensitive.
			var/obj/item/organ/external/chest/C = H.get_organ("chest")
			icobase = C.icobase ? C.icobase : C.species.icobase
			if(H.species.bodyflags & HAS_TAIL)
				coloured_tail = H.tail ? H.tail : H.species.tail

			qdel(H)
		else
			icobase = current_species.icobase
	else
		icobase = 'icons/mob/human_races/r_human.dmi'

	var/fat=""
	if(disabilities & DISABILITY_FLAG_FAT && current_species.flags & CAN_BE_FAT)
		fat="_fat"
	preview_icon = new /icon(icobase, "torso_[g][fat]")
	preview_icon.Blend(new /icon(icobase, "groin_[g]"), ICON_OVERLAY)
	var/head = "head"
	if(alt_head && current_species.bodyflags & HAS_ALT_HEADS)
		var/datum/sprite_accessory/alt_heads/H = alt_heads_list[alt_head]
		if(H.icon_state)
			head = H.icon_state
	preview_icon.Blend(new /icon(icobase, "[head]_[g]"), ICON_OVERLAY)

	for(var/name in list("chest", "groin", "head", "r_arm", "r_hand", "r_leg", "r_foot", "l_leg", "l_foot", "l_arm", "l_hand"))
		if(organ_data[name] == "amputated") continue
		if(organ_data[name] == "cyborg")
			var/datum/robolimb/R
			if(rlimb_data[name]) R = all_robolimbs[rlimb_data[name]]
			if(!R) R = basic_robolimb
			if(name == "chest")
				name = "torso"
			preview_icon.Blend(icon(R.icon, "[name]"), ICON_OVERLAY) // This doesn't check gendered_icon. Not an issue while only limbs can be robotic.
			continue
		preview_icon.Blend(new /icon(icobase, "[name]"), ICON_OVERLAY)

	// Skin color
	if(current_species && (current_species.bodyflags & HAS_SKIN_COLOR))
		preview_icon.Blend(rgb(r_skin, g_skin, b_skin), ICON_ADD)

	// Skin tone
	if(current_species && (current_species.bodyflags & HAS_SKIN_TONE))
		if(s_tone >= 0)
			preview_icon.Blend(rgb(s_tone, s_tone, s_tone), ICON_ADD)
		else
			preview_icon.Blend(rgb(-s_tone,  -s_tone,  -s_tone), ICON_SUBTRACT)

	//Tail
	if(current_species && (current_species.bodyflags & HAS_TAIL))
		var/tail_icon
		var/tail_icon_state
		var/tail_shift_x
		var/tail_shift_y
		var/blend_mode = ICON_ADD

		if(body_accessory)
			var/datum/body_accessory/accessory = body_accessory_by_name[body_accessory]
			tail_icon = accessory.icon
			tail_icon_state = accessory.icon_state
			if(accessory.blend_mode)
				blend_mode = accessory.blend_mode
			if(accessory.pixel_x_offset)
				tail_shift_x = accessory.pixel_x_offset
			if(accessory.pixel_y_offset)
				tail_shift_y = accessory.pixel_y_offset
		else
			tail_icon = "icons/effects/species.dmi"
			if(coloured_tail)
				tail_icon_state = "[coloured_tail]_s"
			else
				tail_icon_state = "[current_species.tail]_s"

		var/icon/temp = new/icon("icon" = tail_icon, "icon_state" = tail_icon_state)
		if(tail_shift_x)
			temp.Shift(EAST, tail_shift_x)
		if(tail_shift_y)
			temp.Shift(NORTH, tail_shift_y)

		if(current_species && (current_species.bodyflags & HAS_SKIN_COLOR))
			temp.Blend(rgb(r_skin, g_skin, b_skin), blend_mode)

		if(current_species && (current_species.bodyflags & HAS_TAIL_MARKINGS))
			var/tail_marking = m_styles["tail"]
			var/datum/sprite_accessory/tail_marking_style = marking_styles_list[tail_marking]
			if(tail_marking_style && tail_marking_style.species_allowed)
				var/icon/t_marking_s = new/icon("icon" = tail_marking_style.icon, "icon_state" = "[tail_marking_style.icon_state]_s")
				t_marking_s.Blend(m_colours["tail"], ICON_ADD)
				temp.Blend(t_marking_s, ICON_OVERLAY)

		preview_icon.Blend(temp, ICON_OVERLAY)

	//Markings
	if(current_species && ((current_species.bodyflags & HAS_HEAD_MARKINGS) || (current_species.bodyflags & HAS_BODY_MARKINGS)))
		if(current_species.bodyflags & HAS_BODY_MARKINGS) //Body markings.
			var/body_marking = m_styles["body"]
			var/datum/sprite_accessory/body_marking_style = marking_styles_list[body_marking]
			if(body_marking_style && body_marking_style.species_allowed)
				var/icon/b_marking_s = new/icon("icon" = body_marking_style.icon, "icon_state" = "[body_marking_style.icon_state]_s")
				b_marking_s.Blend(m_colours["body"], ICON_ADD)
				preview_icon.Blend(b_marking_s, ICON_OVERLAY)
		if(current_species.bodyflags & HAS_HEAD_MARKINGS) //Head markings.
			var/head_marking = m_styles["head"]
			var/datum/sprite_accessory/head_marking_style = marking_styles_list[head_marking]
			if(head_marking_style && head_marking_style.species_allowed)
				var/icon/h_marking_s = new/icon("icon" = head_marking_style.icon, "icon_state" = "[head_marking_style.icon_state]_s")
				h_marking_s.Blend(m_colours["head"], ICON_ADD)
				preview_icon.Blend(h_marking_s, ICON_OVERLAY)


	var/icon/face_s = new/icon("icon" = 'icons/mob/human_face.dmi', "icon_state" = "bald_s")
	if(!(current_species.bodyflags & NO_EYES))
		var/icon/eyes_s = new/icon("icon" = 'icons/mob/human_face.dmi', "icon_state" = current_species ? current_species.eyes : "eyes_s")
		eyes_s.Blend(rgb(r_eyes, g_eyes, b_eyes), ICON_ADD)
		face_s.Blend(eyes_s, ICON_OVERLAY)


	var/datum/sprite_accessory/hair_style = hair_styles_list[h_style]
	if(hair_style)
		var/icon/hair_s = new/icon("icon" = hair_style.icon, "icon_state" = "[hair_style.icon_state]_s")
		if(current_species.name == "Slime People") // whee I am part of the problem
			hair_s.Blend(rgb(r_skin, g_skin, b_skin, 160), ICON_ADD)
		else
			hair_s.Blend(rgb(r_hair, g_hair, b_hair), ICON_ADD)

		if(hair_style.secondary_theme)
			var/icon/hair_secondary_s = new/icon("icon" = hair_style.icon, "icon_state" = "[hair_style.icon_state]_[hair_style.secondary_theme]_s")
			if(!hair_style.no_sec_colour)
				hair_secondary_s.Blend(rgb(r_hair_sec, g_hair_sec, b_hair_sec), ICON_ADD)
			hair_s.Blend(hair_secondary_s, ICON_OVERLAY)

		face_s.Blend(hair_s, ICON_OVERLAY)

	//Head Accessory
	if(current_species && (current_species.bodyflags & HAS_HEAD_ACCESSORY))
		var/datum/sprite_accessory/head_accessory_style = head_accessory_styles_list[ha_style]
		if(head_accessory_style && head_accessory_style.species_allowed)
			var/icon/head_accessory_s = new/icon("icon" = head_accessory_style.icon, "icon_state" = "[head_accessory_style.icon_state]_s")
			head_accessory_s.Blend(rgb(r_headacc, g_headacc, b_headacc), ICON_ADD)
			face_s.Blend(head_accessory_s, ICON_OVERLAY)

	var/datum/sprite_accessory/facial_hair_style = facial_hair_styles_list[f_style]
	if(facial_hair_style && facial_hair_style.species_allowed)
		var/icon/facial_s = new/icon("icon" = facial_hair_style.icon, "icon_state" = "[facial_hair_style.icon_state]_s")
		if(current_species.name == "Slime People") // whee I am part of the problem
			facial_s.Blend(rgb(r_skin, g_skin, b_skin, 160), ICON_ADD)
		else
			facial_s.Blend(rgb(r_facial, g_facial, b_facial), ICON_ADD)

		if(facial_hair_style.secondary_theme)
			var/icon/facial_secondary_s = new/icon("icon" = facial_hair_style.icon, "icon_state" = "[facial_hair_style.icon_state]_[facial_hair_style.secondary_theme]_s")
			if(!facial_hair_style.no_sec_colour)
				facial_secondary_s.Blend(rgb(r_facial_sec, g_facial_sec, b_facial_sec), ICON_ADD)
			facial_s.Blend(facial_secondary_s, ICON_OVERLAY)

		face_s.Blend(facial_s, ICON_OVERLAY)

	var/icon/underwear_s = null
	if(underwear && (current_species.clothing_flags & HAS_UNDERWEAR))
		var/datum/sprite_accessory/underwear/U = underwear_list[underwear]
		if(U)
			underwear_s = new/icon(U.icon, "uw_[U.icon_state]_s", ICON_OVERLAY)

	var/icon/undershirt_s = null
	if(undershirt && (current_species.clothing_flags & HAS_UNDERSHIRT))
		var/datum/sprite_accessory/undershirt/U2 = undershirt_list[undershirt]
		if(U2)
			undershirt_s = new/icon(U2.icon, "us_[U2.icon_state]_s", ICON_OVERLAY)

	var/icon/socks_s = null
	if(socks && (current_species.clothing_flags & HAS_SOCKS))
		var/datum/sprite_accessory/socks/U3 = socks_list[socks]
		if(U3)
			socks_s = new/icon(U3.icon, "sk_[U3.icon_state]_s", ICON_OVERLAY)

	var/icon/clothes_s = new /icon('icons/mob/mob.dmi', "blank")

	// Observers get tourist outfit.
	if(for_observer)
		var/uniform_dmi = 'icons/mob/uniform.dmi'
		if(disabilities&DISABILITY_FLAG_FAT)
			uniform_dmi = 'icons/mob/uniform_fat.dmi'
		clothes_s = new /icon(uniform_dmi, "tourist_s")
		clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
		switch(backbag)
			if(DSATCHEL,GSATCHEL,LSATCHEL)
				clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel"), ICON_OVERLAY)
			else
				clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
	else
		var/job_title = get_high_pref_job_name()
		var/datum/job/J = job_master.GetJob(job_title)

		clothes_s = J.apply_preview_icon(clothes_s, backbag, fat=!!(disabilities&DISABILITY_FLAG_FAT))

	if(disabilities & NEARSIGHTED)
		preview_icon.Blend(new /icon('icons/mob/eyes.dmi', "glasses"), ICON_OVERLAY)

	if(underwear_s)
		preview_icon.Blend(underwear_s, ICON_OVERLAY)
	if(undershirt_s)
		preview_icon.Blend(undershirt_s, ICON_OVERLAY)
	if(socks_s)
		preview_icon.Blend(socks_s, ICON_OVERLAY)
	if(clothes_s)
		preview_icon.Blend(clothes_s, ICON_OVERLAY)
	preview_icon.Blend(face_s, ICON_OVERLAY)
	preview_icon_front = new(preview_icon, dir = SOUTH)
	preview_icon_side = new(preview_icon, dir = WEST)

	qdel(face_s)
	qdel(underwear_s)
	qdel(undershirt_s)
	qdel(socks_s)
	qdel(clothes_s)

/datum/preferences/proc/get_high_pref_job_name()
	var/datum/job/J
	var/rank_flag
	var/dep_flag
	if(job_support_low & CIVILIAN)
		return "Civilian"
	else if(job_support_high)//I hate how this looks, but there's no reason to go through this switch if it's empty
		rank_flag = job_support_high
		dep_flag = SUPPORT
	else if(job_medsci_high)
		rank_flag = job_medsci_high
		dep_flag = MEDSCI
	else if(job_engsec_high)
		rank_flag = job_engsec_high
		dep_flag = ENGSEC
	else if(job_karma_high)
		rank_flag = job_karma_high
		dep_flag = KARMA
	else
		return "Civilian"
	J = job_master.GetJobByID(rank_flag, dep_flag)
	return J.title

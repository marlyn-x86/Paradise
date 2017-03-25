/mob/living/death(gibbed)
	. = ..(gibbed)
	if(!.)
		return

	if(!gibbed && deathgasp_on_death)
		emote("deathgasp")

	blinded = max(blinded, 1)

	clear_fullscreens()
	update_action_buttons_icon()
	if(mind && mind.devilinfo) // Expand this into a general-purpose death-response system when appropriate
		mind.devilinfo.beginResurrectionCheck()

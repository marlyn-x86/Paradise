/mob/living/death(gibbed)
	. = ..(gibbed)
	if(!.)
		return

	if(!gibbed && deathgasp_on_death)
		emote("deathgasp")

	blinded = max(blinded, 1)

	if(suiciding)
		mind.suicided = TRUE

	clear_fullscreens()
	update_action_buttons_icon()

	for(var/s in ownedSoullinks)
		var/datum/soullink/S = s
		S.ownerDies(gibbed, src)
	for(var/s in sharedSoullinks)
		var/datum/soullink/S = s
		S.sharerDies(gibbed, src)

	med_hud_set_health()
	med_hud_set_status()
	if(mind && mind.devilinfo) // Expand this into a general-purpose death-response system when appropriate
		mind.devilinfo.beginResurrectionCheck(src)

	..(gibbed)

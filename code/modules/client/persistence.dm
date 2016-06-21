/datum/persistent_data
  var/money
  var/injuries


/datum/peristent_data/proc/save(var/mob/living/carbon/human/H)
  if(!H.mind)
    return // No mind, no persistence - a "mind" corresponds to a character

  

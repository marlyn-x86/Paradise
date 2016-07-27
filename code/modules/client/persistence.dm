/datum/persistent_data
  var/money = 500
  var/body_data = ""
  var/datum/preferences/P

/datum/persistent_data/proc/wipe()
  money = 500 // A meager sum or something. Maybe should go back to 0? idk
  body_data = ""

/datum/persistent_data/proc/sync_info(var/mob/living/carbon/human/H)
  save_money(H)
  save_body(H)

/datum/persistent_data/proc/save_money(var/mob/living/carbon/human/H)
  money = H.mind.initial_account.money

/datum/persistent_data/proc/save_body(var/mob/living/carbon/human/H)
  body_data = json_encode(H.serialize())
  // Remove the stupid extra quotes given to the string for some reason
  body_data = copytext(body_data, 2, -1)

/*
* Returns a byond path that can be passed to the "deserialize" proc
* to bring a new instance of this atom to its original state
*
* If we want to store this info, we can pass it to `json_encode` or some other
* interface that suits our fancy, to make it into an easily-handled string
*/
/atom/movable/proc/serialize()
  return list("type" = "[type]")

/*
* This is given the byond list from above, to bring this atom to the state
* described in the list.
* This will be called after `New` but before `initialize`, so linking and stuff
* would probably be handled in `initialize`
*
* Also, this should only be called by `json_to_object` in persistence.dm - at least
* with current plans - that way it can actually initialize the type from the list
*/
/atom/movable/proc/deserialize(var/data)
  return

/proc/json_to_object(var/json_data, var/loc)
  var/data = json_decode(json_data)
  return list_to_object(data, loc)

/proc/list_to_object(var/list/data, var/loc)
  if(!islist(data))
    throw EXCEPTION("You didn't give me a list, bucko")
  if(!("type" in data))
    throw EXCEPTION("No 'type' field in the data")
  var/path = text2path(data["type"])
  if(!path)
    throw EXCEPTION("Path not found: [path]")

  var/atom/movable/thing = new path(loc)
  thing.deserialize(data)
  return thing

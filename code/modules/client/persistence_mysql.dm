// SQL jibberjabber
/datum/persistent_data/proc/save(var/mob/living/carbon/human/H)
  if(!H.mind)
    return // No mind, no persistence - a "mind" corresponds to a character

  // Do checks so that we don't allow any nasty vars in

  var/ckey = sql_sanitize_text(H.mind.ckey)
  if(ckey != H.mind.ckey)
    log_debug("Something funny happened with the ckey in persistent saving! Ckey: [ckey]")
    // If the ckey's bunk, lookup will fail - don't bother
    return
  var/default_slot = H.mind.slot
  if(!isnum(default_slot))
    default_slot = 1

  // Money stuff
  var/moneycash = money
  if(!isnum(moneycash))
    log_debug("Bad value for [H]'s money value: [moneycash]'")
    moneycash = 0
  // Injury stuff
  var/body_json = sql_sanitize_text(body_data)
  if(body_json != body_data)
    log_debug("The body data contained illegal characters for SQL!")
    return // Hopefully this never comes up

  log_debug("Ckey: [ckey], Slot: [default_slot]")
  var/DBQuery/firstquery = dbcon.NewQuery("SELECT slot FROM [format_table_name("characters")] WHERE ckey='[ckey]' ORDER BY slot")
  firstquery.Execute()
  while(firstquery.NextRow())
    if(text2num(firstquery.item[1]) == default_slot)
      var/DBQuery/query = dbcon.NewQuery({"UPDATE [format_table_name("characters")] SET
                      money='[moneycash]',
                      body_data='[body_json]'
                      WHERE ckey='[ckey]'
                      AND slot='[default_slot]'"}
                      )
      if(!query.Execute())
        var/err = query.ErrorMsg()
        log_game("SQL ERROR during character slot saving. Error : \[[err]\]\n")
        message_admins("SQL ERROR during character slot saving. Error : \[[err]\]\n")
        return
      return 1
  log_game("SQL MISHAP no slot found, not saving char")
  return

/datum/persistent_data/proc/load(client/C,slot)

  var/DBQuery/query = dbcon.NewQuery({"SELECT
          money,
          body_data
          FROM [format_table_name("characters")]
          WHERE ckey='[C.ckey]'
          AND slot='[slot]'"}
          )

  if(!query.Execute())
    var/err = query.ErrorMsg()
    log_game("SQL ERROR during loading player preferences. Error : \[[err]\]\n")
    message_admins("SQL ERROR during loading player preferences. Error : \[[err]\]\n")
    return


  //general preferences
  while(query.NextRow())
    money = text2num(query.item[1])
    log_debug("Money value: [money]")
    body_data = query.item[2]

  //Sanitize
  // I'm insane
  return 1

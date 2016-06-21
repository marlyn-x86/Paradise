// Call this each time you want to pay a mob its salary
// Normally only makes sense for humans
/mob/living/proc/salary()
  // TODO(crazylemon): Should probably separate this from the mob/mind at some point
  // so that the HoP needs to manually update the registry if someone gets
  // blown up or similar, or to allow for actual banking fraud
  var/payment_success = 0
  if(mind && mind.initial_account && mind.assigned_job)
    var/datum/money_account/D = department_accounts[mind.assigned_job.department]
    var/term_id = rand(111,333)
    payment_success = D.charge(M.mind.wage, M.mind.initial_account, "Job Payroll", "\[CLASSIFIED\] Terminal #[term_id]", term_id)
  return payment_success

/mob/living/proc/serialize_money()
  

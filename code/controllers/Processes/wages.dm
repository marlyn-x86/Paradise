var/global/datum/controller/process/wages/wages_master

/datum/controller/process/wages

/datum/controller/process/wages/setup()
	name = "wages"
	schedule_interval = 18000 // every 30 minutes (60 s * 30 m * 10 t)
	start_delay = 16
	log_startup_progress("Wage ticker starting up.")
	if(wages_master)
		qdel(wages_master) //only one mob master
	wages_master = src

/datum/controller/process/wages/started()
  //Might need to insert stuff here
	..()

/datum/controller/process/wages/doWork()
  // holla holla get dolla
	for(var/datum/job/J in job_master.occupations)
		J.do_payments()

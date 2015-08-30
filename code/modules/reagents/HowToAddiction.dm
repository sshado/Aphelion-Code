/* the following code is how the implmentation of addiction is handled

datum/reagent/(yourregement)/addiction_act_stage(1-4)(var/mob/living/M as mob)
	if(prob(33))
		M.adjustToxLoss(2*REM) //You could add what ever the hell you wanted here
		M.losebreath += 2    // same for here
	..()
	return

	remember to add (addiction_threshold = (number) To your drugs.
	Ported from Paradise :/
	/*

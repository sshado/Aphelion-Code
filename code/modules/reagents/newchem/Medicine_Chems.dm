#define SOLID 1
#define LIQUID 2
#define GAS 3

#define REM REAGENTS_EFFECT_MULTIPLIER

//////////////////////////////////////
//MEDICINES//
/////////////////////////////////////

//Anti-Tox//
//T1-1
/datum/reagent/anti_toxin
	name = "Dylovene"
	id = "anti_toxin"
	description = "Dylovene is a broad-spectrum antitoxin. Reduces hallucinations faster than charcoal"
	reagent_state = LIQUID
	color = "#00A000"
	scannable = 1

/datum/chemical_reaction/anti_toxin
	name = "Dylovene"
	id = "anti_toxin"
	result = "anti_toxin"
	required_reagents = list("nitrogen" = 1, "potassium" = 1, "silicon" = 1)
	result_amount = 3
	max_temp = 302

datum/reagent/anti_toxin/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.adjustToxLoss(-0.5*REM)
	if(prob(50))
		for(var/datum/reagent/R in M.reagents.reagent_list)
			if(R != src)
				M.reagents.remove_reagent(R.id,1)
	..()
	return

datum/reagent/charcoal
	name = "Charcoal"
	id = "charcoal"
	description = "Activated charcoal helps to absorb toxins."
	reagent_state = LIQUID
	color = "#000000"
	scannable = 1

datum/reagent/charcoal/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.adjustToxLoss(-0.7*REM)
	if(prob(35))
		for(var/datum/reagent/R in M.reagents.reagent_list)
			if(R != src)
				M.reagents.remove_reagent(R.id,1)
	..()
	return

/datum/chemical_reaction/charcoal
	name = "Charcoal"
	id = "charcoal"
	result = "charcoal"
	required_reagents = list("ash" = 1, "sodiumchloride" = 1)
	result_amount = 2
	mix_message = "The mixture yields a fine black powder."
	min_temp = 407

//T2
/datum/reagent/alkysine
	name = "Alkysine"
	id = "alkysine"
	description = "Alkysine is a more powerful form of Dylovene. It can remove toxins faster and heal slight brain damage."
	color = "#FFFF66"
	metabolism = REM * 0.25
	overdose_threshold = 35
	scannable = 1

/datum/chemical_reaction/alkysine
	name = "Alkysine"
	id = "alkysine"
	result = "alkysine"
	required_reagents = list("anti_toxin" = 2, "silicon" = 1, "carbon" = 1)
	result_amount = 3

/datum/reagent/alkysine/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	M.adjustBrainLoss(-1 * removed)
	M.drowsyness = max(0, M.drowsyness - 4 * removed)
	M.adjustToxLoss(-1.5*REM)

datum/reagent/alkysine/overdose_process(var/mob/living/M as mob)
	if(prob(50))
		M.adjustToxLoss(2*REM)
	..()
	return

//T3
/datum/reagent/neodextraminesolution
	name = "Neodextramine Solution"
	id = "neodextraminesolution"
	description = "This potent purgative rids the body of impurities. It is highly toxic however and close supervision is required."
	color = "#FFFF66"
	metabolism = 0.8
	overdose_threshold = 20
datum/reagent/neodextraminesolution/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	for(var/datum/reagent/R in M.reagents.reagent_list)
		if(R != src)
			M.reagents.remove_reagent(R.id,5)
	if(M.health > 65)
		M.adjustToxLoss(5*REM)
	if(prob(10))
		M.fakevomit()
	..()
	return
/datum/chemical_reaction/neodextraminesolution
	name = "Neodextramine Solution"
	id = "neodextraminesolution"
	result = "neodextraminesolution"
	required_reagents = list("alkysine" = 1, "mercury" = 1, )
	result_amount = 2
	max_temp = 273
	mix_message = "Stinging vapors rise from the solution."

datum/reagent/neodextraminesolution/overdose_process(var/mob/living/M as mob)
	if(prob(66))
		M.adjustToxLoss(3*REM)
	if(prob(33))
		M.fakevomit()
	if(prob(12))
		M.adjustBruteLoss(1*REM)
	..()
	return
	..()
	return


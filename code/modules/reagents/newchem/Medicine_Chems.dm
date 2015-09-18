#define SOLID 1
#define LIQUID 2
#define GAS 3

#define REM REAGENTS_EFFECT_MULTIPLIER

///////////////////////////////////////////////////////////////
//MEDICINES//// Tier 1, Tier 2, Tier 3, Tier 4, Tier 5, Tier 6
///////////////////////////////////////////////////////////////


//ANTI TOXIN//
//Tier 1/////
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
/datum/reagent/anti_toxin/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.adjustToxLoss(-0.35*REM)
	if(prob(50))
		for(var/datum/reagent/R in M.reagents.reagent_list)
			if(R != src)
				M.reagents.remove_reagent(R.id,1)
	..()
	return

//Tier 1+///////////////////////////////////////////////////////////////////////////////////
//ANTI TOXIN//
datum/reagent/charcoal
	name = "Charcoal"
	id = "charcoal"
	description = "Activated charcoal helps to absorb toxins."
	reagent_state = LIQUID
	color = "#000000"
	scannable = 1
/datum/reagent/charcoal/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.adjustToxLoss(-0.55*REM)
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
	required_reagents = list("trihydrocarbon" = 2, "oxygen" = 1, "silicon" = 1)
	result_amount = 2
	mix_message = "The mixture yields a fine black powder."
	min_temp = 407

//Tier 2////////////////////////////////////////////////////////////////////////////////////
//ANTI TOXIN//
/datum/reagent/alkysine
	name = "Alkysine"
	id = "alkysine"
	description = "Alkysine is a more powerful form of Dylovene. It can remove toxins faster and heal slight brain damage."
	color = "#FFFF66"
	metabolism = 0.4
	overdose_threshold = 35
	scannable = 1
/datum/reagent/alkysine/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	M.adjustBrainLoss(-1 * removed)
	M.drowsyness = max(0, M.drowsyness - 4 * removed)
	M.adjustToxLoss(-1.5*REM)
/datum/chemical_reaction/alkysine
	name = "Alkysine"
	id = "alkysine"
	result = "alkysine"
	required_reagents = list("anti_toxin" = 2, "silicon" = 1, "carbon" = 1)
	result_amount = 3

/datum/reagent/alkysine/overdose_process(var/mob/living/M as mob)
	if(prob(50))
		M.adjustToxLoss(2*REM)
	..()
	return

//Tier 3////////////////////////////////////////////////////////////////////////////////////
//ANTI TOXIN//
/datum/reagent/neodextraminesolution
	name = "Neodextramine Solution"
	id = "neodextraminesolution"
	description = "This potent purgative rids the body of impurities. It is highly toxic however and close supervision is required."
	color = "#FFFF66"
	metabolism = 0.65
	overdose_threshold = 20
/datum/reagent/neodextraminesolution/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	for(var/datum/reagent/R in M.reagents.reagent_list)
		if(R != src)
			M.reagents.remove_reagent(R.id,5)
	if(M.health > 60)
		M.adjustToxLoss(4.25*REM)
	if(prob(44))
		M.fakevomit()
	..()
	return
/datum/chemical_reaction/neodextraminesolution
	name = "Neodextramine Solution"
	id = "neodextraminesolution"
	result = "neodextraminesolution"
	required_reagents = list("alkysine" = 1, "mercury" = 1, "xenofloracarbon" = 1)
	result_amount = 2
	max_temp = 273
	mix_message = "Stinging vapors rise from the solution."

/datum/reagent/neodextraminesolution/overdose_process(var/mob/living/M as mob)
	if(prob(66))
		M.adjustToxLoss(3*REM)
	if(prob(44))
		M.fakevomit()
	if(prob(12))
		M.adjustBruteLoss(1*REM)
	..()
	return

//Tier 4////////////////////////////////////////////////////////////////////////////////////
//ANTI TOXIN//
/datum/reagent/dermalopein
	name = "Dermalopein"
	id = "dermalopein"
	description = "This chemical rapidly purges all chemicals out of its user's system. It is extremely toxic however and only works if the paitent is near death."
	color = "#FFFF66"
	metabolism = 0.8
	overdose_threshold = 15
/datum/reagent/dermalopein/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	for(var/datum/reagent/R in M.reagents.reagent_list)
		if(R != src)
			M.reagents.remove_reagent(R.id,5)
	if(M.health > 25)
		M.adjustToxLoss(6*REM)
	if(prob(70))
		M.fakevomit()
	..()
	return
/datum/chemical_reaction/dermalopein
	name = "Dermalopein"
	id = "dermalopein"
	result = "dermalopein"
	required_reagents = list("neodextraminesolution" = 1, "bisacodyl" = 1)
	required_catalysts = list("xenofloracarbon" = 5)
	result_amount = 2
	max_temp = 250
/datum/reagent/dermalopein/overdose_process(var/mob/living/M as mob)
	if(prob(70))
		M.Seizures()
		M.adjustToxLoss(3*REM)
	if(prob(66))
		M.make_jittery(5)
		M.make_dizzy(5)
		M.druggy = max(M.druggy, 35)
	if(prob(50))
		M.fakevomit()
	if(prob(12))
		M.adjustBruteLoss(1*REM)
	..()
	return

//Brain Damage////
//Tier 1////////

/datum/reagent/sodium_pentathol
	name = "Sodium Pentahol"
	id = "sodium_pentahol"
	description = "Sodium Pentahol reduces minior brain trama."
	reagent_state = LIQUID
	color = "#00A000"
	scannable = 1
/datum/chemical_reaction/sodium_pentahol
	name = "Sodium Pentahol"
	id = "sodium_pentahol"
	result = "sodium_pentahol"
	required_reagents = list("salinesolution" = 1, "pentahol" = 1)
	result_amount = 3
/datum/reagent/anti_toxin/on_mob_life(var/mob/living/M as mob)
	M.adjustBrainLoss(-0.65)
	..()
	return

//Brain Damage////
//Tier 2////////

datum/reagent/dramadorax
	name = "Dramadorax"
	id = "dramadorax"
	description = "Activated charcoal helps to absorb toxins."
	reagent_state = LIQUID
	color = "#000000"
	scannable = 1
/datum/reagent/dramadorax/on_mob_life(var/mob/living/M as mob)
	M.adjustBrainLoss(-1.95)
	M.adjustToxLoss(-0.35)
	..()
	return
/datum/chemical_reaction/dramadorax
	name = "Dramadorax"
	id = "dramadorax"
	result = "dramadorax"
	required_reagents = list("trihydrocarbon" = 2, "oxygen" = 1, "silicon" = 1)
	result_amount = 2
	min_temp = 407


//Brain Damage////
//Tier 3////////

/datum/reagent/mannitol
	name = "Mannitol"
	id = "mannitol"
	description = "Activated charcoal helps to absorb toxins."
	reagent_state = LIQUID
	color = "#000000"
	scannable = 1
/datum/reagent/mannitol/on_mob_life(var/mob/living/M as mob)
	M.adjustBrainLoss(-2.85)
	M.adjustToxLoss(-0.75)
	..()
	return
/datum/chemical_reaction/mannitol
	name = "Mannitol"
	id = "mannitol"
	result = "mannitol"
	required_reagents = list("trihydrocarbon" = 2, "oxygen" = 1, "silicon" = 1)
	result_amount = 2
	min_temp = 407


//Oxygen Loss////
//Tier 1////////

/datum/reagent/hexadrol
	name = "Hexadrol"
	id = "hexadrol"
	description = "Salbutamol is a common bronchodilation medication for asthmatics. It may help with other breathing problems as well."
	reagent_state = LIQUID
	color = "#00FFFF"
	metabolization_rate = 0.2
/datum/reagent/hexadrol/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.adjustOxyLoss(-2.5*REM)
	..()
	return
/datum/chemical_reaction/hexadrol
	name = "Hexadrol"
	id = "hexadrol"
	result = "hexadrol"
	required_reagents = list("sal_acid" = 1, "lithium" = 1, "aluminum" = 1, "bromine" = 1, "ammonia" = 1)
	result_amount = 5
	mix_message = "The solution bubbles freely, creating a head of bluish foam."

//Oxygen Loss////
//Tier 2////////

/datum/reagent/oxycocet
	name = "Oxycocet"
	id = "oxycocet"
	description = "Salbutamol is a common bronchodilation medication for asthmatics. It may help with other breathing problems as well."
	reagent_state = LIQUID
	color = "#00FFFF"
	metabolization_rate = 0.2
/datum/reagent/oxycocet/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.adjustOxyLoss(-2.5*REM)
	..()
	return
/datum/chemical_reaction/oxycocet
	name = "Oxycocet"
	id = "oxycocet"
	result = "oxycocet"
	required_reagents = list("sal_acid" = 1, "lithium" = 1, "aluminum" = 1, "bromine" = 1, "ammonia" = 1)
	result_amount = 5
	mix_message = "The solution bubbles freely, creating a head of bluish foam."

//Oxygen Loss////
//Tier 3////////


/datum/reagent/oxycocetosmo
	name = "Oxycocet Osmo"
	id = "oxycocetosmo"
	description = "Salbutamol is a common bronchodilation medication for asthmatics. It may help with other breathing problems as well."
	reagent_state = LIQUID
	color = "#00FFFF"
	metabolization_rate = 0.2
/datum/reagent/oxycocetosmo/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.adjustOxyLoss(-2.5*REM)
	..()
	return
/datum/chemical_reaction/oxycocetosmo
	name = "Oxycocet Osmo"
	id = "oxycocetosmo"
	result = "oxycocetosmo"
	required_reagents = list("sal_acid" = 1, "lithium" = 1, "aluminum" = 1, "bromine" = 1, "ammonia" = 1)
	result_amount = 5
	mix_message = "The solution bubbles freely, creating a head of bluish foam."

//Oxygen Loss////
//Tier 4////////

datum/reagent/perfluorodecalin
	name = "Perfluorodecalin"
	id = "perfluorodecalin"
	description = "This experimental perfluoronated solvent has applications in liquid breathing and tissue oxygenation. Use with caution."
	reagent_state = LIQUID
	color = "#C8A5DC"
	metabolization_rate = 0.2

datum/reagent/perfluorodecalin/on_mob_life(var/mob/living/carbon/human/M as mob)
	if(!M) M = holder.my_atom
	M.adjustOxyLoss(-25*REM)
	M.silent = max(M.silent, 5)
	if(prob(33))
		M.adjustBruteLoss(-1*REM)
		M.adjustFireLoss(-1*REM)
	..()
	return

/datum/chemical_reaction/perfluorodecalin
	name = "Perfluorodecalin"
	id = "perfluorodecalin"
	result = "perfluorodecalin"
	required_reagents = list("hydrogen" = 1, "fluorine" = 1, "oil" = 1)
	result_amount = 3
	min_temp = 370
	mix_message = "The mixture rapidly turns into a dense pink liquid."

//Brute Damage////
//Tier 1////////

/datum/reagent/oxycocetosmo
	name = "Oxycocet Osmo"
	id = "oxycocetosmo"
	description = "Salbutamol is a common bronchodilation medication for asthmatics. It may help with other breathing problems as well."
	reagent_state = LIQUID
	color = "#00FFFF"
	metabolization_rate = 0.2
/datum/reagent/pen_acid/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(prob(99))
		M.adjustBruteLoss(-0.75*REM)
	if(prob(49))
		M.adjustBruteLoss(-1.5*REM)
	..()
	return
/datum/chemical_reaction/oxycocetosmo
	name = "Oxycocet Osmo"
	id = "oxycocetosmo"
	result = "oxycocetosmo"
	required_reagents = list("sal_acid" = 1, "lithium" = 1, "aluminum" = 1, "bromine" = 1, "ammonia" = 1)
	result_amount = 5
	mix_message = "The solution bubbles freely, creating a head of bluish foam."

//Brute Damage////
//Tier 2////////

/datum/reagent/oxycocetosmo
	name = "Oxycocet Osmo"
	id = "oxycocetosmo"
	description = "Salbutamol is a common bronchodilation medication for asthmatics. It may help with other breathing problems as well."
	reagent_state = LIQUID
	color = "#00FFFF"
	metabolization_rate = 0.2
/datum/reagent/pen_acid/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(prob(99))
		M.adjustBruteLoss(-1.5*REM)
	if(prob(49))
		M.adjustBruteLoss(-2.5*REM)
	..()
	return
/datum/chemical_reaction/oxycocetosmo
	name = "Oxycocet Osmo"
	id = "oxycocetosmo"
	result = "oxycocetosmo"
	required_reagents = list("sal_acid" = 1, "lithium" = 1, "aluminum" = 1, "bromine" = 1, "ammonia" = 1)
	result_amount = 5
	mix_message = "The solution bubbles freely, creating a head of bluish foam."

//Brute Damage////
//Tier 3////////

/datum/reagent/oxycocetosmo
	name = "Oxycocet Osmo"
	id = "oxycocetosmo"
	description = "Salbutamol is a common bronchodilation medication for asthmatics. It may help with other breathing problems as well."
	reagent_state = LIQUID
	color = "#00FFFF"
	metabolization_rate = 0.2

/datum/reagent/pen_acid/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(prob(99))
		M.adjustBruteLoss(-1.5*REM)
	if(prob(49))
		M.adjustBruteLoss(-2.5*REM)
	..()
	return

/datum/chemical_reaction/oxycocetosmo
	name = "Oxycocet Osmo"
	id = "oxycocetosmo"
	result = "oxycocetosmo"
	required_reagents = list("sal_acid" = 1, "lithium" = 1, "aluminum" = 1, "bromine" = 1, "ammonia" = 1)
	result_amount = 5
	mix_message = "The solution bubbles freely, creating a head of bluish foam."

//Stimulant (Nervous System & Heart)////
//Tier 5 (Special Drug)//

/datum/reagent/ephedrine
	name = "Ephedrine"
	id = "ephedrine"
	description = "Ephedrine is a plant-derived stimulant."
	reagent_state = LIQUID
	color = "#C8A5DC"
	metabolization_rate = 0.3
	overdose_threshold = 45
	addiction_threshold = 30

/datum/reagent/ephedrine/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.AdjustParalysis(-1)
	M.AdjustStunned(-1)
	M.AdjustWeakened(-1)
	..()
	return

/datum/reagent/ephedrine/overdose_process(var/mob/living/M as mob)
	if(prob(33))
		M.adjustToxLoss(1*REM)
		M.losebreath++
	..()
	return

/datum/reagent/ephedrine/addiction_act_stage1(var/mob/living/M as mob)
	if(prob(33))
		M.adjustToxLoss(2*REM)
		M.losebreath += 2
	..()
	return
/datum/reagent/ephedrine/addiction_act_stage2(var/mob/living/M as mob)
	if(prob(33))
		M.adjustToxLoss(3*REM)
		M.losebreath += 3
	..()
	return
/datum/reagent/ephedrine/addiction_act_stage3(var/mob/living/M as mob)
	if(prob(33))
		M.adjustToxLoss(4*REM)
		M.losebreath += 4
	..()
	return
/datum/reagent/ephedrine/addiction_act_stage4(var/mob/living/M as mob)
	if(prob(33))
		M.adjustToxLoss(5*REM)
		M.losebreath += 5
	..()
	return

/datum/chemical_reaction/ephedrine
	name = "Ephedrine"
	id = "ephedrine"
	result = "ephedrine"
	required_reagents = list("sugar" = 1, "oil" = 1, "hydrogen" = 1, "diethylamine" = 1)
	result_amount = 4
	mix_message = "The solution fizzes and gives off toxic fumes."

//Stimulant (Nervous System & Heart)////
//Tier 5 (Special Drug)//

/datum/reagent/crystodigin
	name = "Crystodigin"
	id = "crystodigin"
	description = "Salbutamol is a common bronchodilation medication for asthmatics. It may help with other breathing problems as well."
	reagent_state = LIQUID
	color = "#00FFFF"
	metabolization_rate = 0.65
	overdose_threshold = 45
	addiction_threshold = 30

/datum/reagent/pen_acid/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(prob(99))
		M.adjustBruteLoss(-1.5*REM)
	if(prob(49))
		M.adjustBruteLoss(-2.5*REM)
	..()
	return

/datum/reagent/crystodigin/overdose_process(var/mob/living/M as mob)
	if(prob(33))
		M.adjustToxLoss(1*REM)
		M.losebreath++
	..()
	return

/datum/reagent/crystodigin/addiction_act_stage1(var/mob/living/M as mob)
	if(prob(33))
		M.adjustToxLoss(2*REM)
		M.losebreath += 2
	..()
	return
/datum/reagent/crystodigin/addiction_act_stage2(var/mob/living/M as mob)
	if(prob(33))
		M.adjustToxLoss(3*REM)
		M.losebreath += 3
	..()
	return
/datum/reagent/crystodigin/addiction_act_stage3(var/mob/living/M as mob)
	if(prob(33))
		M.adjustToxLoss(4*REM)
		M.losebreath += 4
	..()
	return
/datum/reagent/crystodigin/addiction_act_stage4(var/mob/living/M as mob)
	if(prob(33))
		M.adjustToxLoss(5*REM)
		M.losebreath += 5
	..()
	return

/datum/chemical_reaction/crystodigin
	name = "Crystodigin"
	id = "crystodigin"
	result = "crystodigin"
	required_reagents = list("sal_acid" = 1, "lithium" = 1, "aluminum" = 1, "bromine" = 1, "ammonia" = 1)
	result_amount = 5
	mix_message = "The solution bubbles freely, creating a head of bluish foam."




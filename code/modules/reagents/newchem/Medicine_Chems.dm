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
	color = "#003303"
	metabolism = 0.3
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
	if(prob(45))
		for(var/datum/reagent/R in M.reagents.reagent_list)
			if(R != src)
				M.reagents.remove_reagent(R.id,1)
	..()
	return

//ANTI TOXIN//
//Tier 1 Alt//

datum/reagent/charcoal
	name = "Charcoal"
	id = "charcoal"
	description = "Activated charcoal helps to absorb toxins."
	reagent_state = LIQUID
	color = "#000000"
	metabolism = 0.15
	scannable = 1
/datum/reagent/charcoal/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.adjustToxLoss(-0.45*REM)
	if(prob(30))
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
	min_temp = 435

//ANTI TOXIN//
//Tier 2/////

/datum/reagent/alkysine
	name = "Alkysine"
	id = "alkysine"
	description = "Alkysine is a more powerful form of Dylovene. It can remove toxins faster and heal minor brain damage."
	color = "#06840d"
	metabolism = 0.3
	overdose_threshold = 45
	scannable = 1
/datum/reagent/alkysine/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	M.adjustBrainLoss(-0.20*REM)
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
		M.adjustToxLoss(0.5*REM)
	..()
	return

//ANTI TOXIN//
//Tier 3/////

/datum/reagent/neodextraminesolution
	name = "Neodextramine Solution"
	id = "neodextraminesolution"
	description = "This potent purgative quickly rids the body of impurities. It is highly toxic however and close supervision is required."
	color = "#8ab31e"
	metabolism = 0.65
	overdose_threshold = 20
/datum/reagent/neodextraminesolution/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	for(var/datum/reagent/R in M.reagents.reagent_list)
		if(R != src)
			M.reagents.remove_reagent(R.id,5)
	if(prob(80))
		M.adjustToxLoss(-2*REM)
	if(M.health > 65)
		M.adjustToxLoss(4*REM)
	if(prob(50))
		M.fakevomit()
	..()
	return
/datum/chemical_reaction/neodextraminesolution
	name = "Neodextramine Solution"
	id = "neodextraminesolution"
	result = "neodextraminesolution"
	required_reagents = list("alkysine" = 1, "mercury" = 1, "xenofloracarbon" = 1)
	result_amount = 2
	max_temp = 315
/datum/reagent/neodextraminesolution/overdose_process(var/mob/living/M as mob)
	if(prob(60))
		M.adjustToxLoss(3*REM)
	if(prob(40))
		M.fakevomit()
	if(prob(10))
		M.adjustInternalBurn(0.75*REM)
	..()
	return

//ANTI TOXIN//
//Tier 4/////

/datum/reagent/dermalopein
	name = "Dermalopein"
	id = "dermalopein"
	description = "This chemical rapidly purges all chemicals out of its user's system. It is extremely toxic however and only works if the paitent is near death."
	color = "#c5e024"
	metabolism = 0.85
	overdose_threshold = 15
/datum/reagent/dermalopein/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	for(var/datum/reagent/R in M.reagents.reagent_list)
		if(R != src)
			M.reagents.remove_reagent(R.id,5)
	if(prob(90))
		M.adjustToxLoss(-3*REM)
	if(M.health > 25)
		M.adjustToxLoss(6*REM)
	if(prob(75))
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
	if(prob(80))
		M.adjustInternalBurn(2*REM)
		M.adjustToxLoss(3*REM)
	if(prob(60))
		M.make_dizzy(5)
		M.fakevomit()
	if(prob(20))
		M.adjustBruteLoss(1*REM)
	..()
	return

//Brain Damage////
//Tier 1////////

/datum/reagent/sodium_pentathol
	name = "Sodium Pentahol"
	id = "sodium_pentahol"
	description = "Sodium Pentahol reduces brain swelling."
	reagent_state = LIQUID
	color = "#2be985"
	scannable = 1
/datum/chemical_reaction/sodium_pentahol
	name = "Sodium Pentahol"
	id = "sodium_pentahol"
	result = "sodium_pentahol"
	required_reagents = list("salinesolution" = 1, "pentahol" = 1)
	result_amount = 3
/datum/reagent/anti_toxin/on_mob_life(var/mob/living/M as mob)
	M.adjustBrainLoss(-0.70*REM)
	..()
	return

//Brain Damage////
//Tier 2////////

datum/reagent/dramadorax
	name = "Dramadorax"
	id = "dramadorax"
	description = "Dramadorax works by encourging the recovery of damaged brain cells, healing most traumatic brain injuries."
	reagent_state = LIQUID
	color = "#52fecd"
	scannable = 1
/datum/reagent/dramadorax/on_mob_life(var/mob/living/M as mob)
	M.adjustBrainLoss(-1.80*REM)
	M.adjustToxLoss(-0.20*REM)
	..()
	return
/datum/chemical_reaction/dramadorax
	name = "Dramadorax"
	id = "dramadorax"
	result = "dramadorax"
	required_reagents = list("trihydrocarbon" = 1, "sodium_pentathol" = 1, "oxygen" = 1)
	result_amount = 2
	max_temp = 367


//Brain Damage////
//Tier 3////////

/datum/reagent/mannitol
	name = "Mannitol"
	id = "mannitol"
	description = "Mannitol encourges growth of new brain cells, and is capable of reversing total neurological damage."
	reagent_state = LIQUID
	color = "#2ee6ef"
	scannable = 1
/datum/reagent/mannitol/on_mob_life(var/mob/living/M as mob)
	M.adjustBrainLoss(-3.0*REM)
	M.adjustToxLoss(-0.25*REM)
	..()
	return
/datum/chemical_reaction/mannitol
	name = "Mannitol"
	id = "mannitol"
	result = "mannitol"
	required_reagents = list("dramadorax" = 2, "oxygen" = 1, "silicon" = 1)
	result_amount = 2
	max_temp = 296


//Oxygen Loss////
//Tier 1////////

/datum/reagent/hexadrol
	name = "Hexadrol"
	id = "hexadrol"
	description = "Hexadrol is a fast acting respiratory stimulant used to improve airflow in a paitent."
	reagent_state = LIQUID
	color = "#1e9499"
	metabolization_rate = 0.45
/datum/reagent/hexadrol/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.adjustOxyLoss(-4*REM)
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
	description = "Oxycocet is a common bronchodilation medication for asthmatics. It may help with other breathing problems as well."
	reagent_state = LIQUID
	color = "#125b68"
	metabolization_rate = 0.4
/datum/reagent/oxycocet/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.adjustOxyLoss(-10*REM)
	..()
	return
/datum/chemical_reaction/oxycocet
	name = "Oxycocet"
	id = "oxycocet"
	result = "oxycocet"
	required_reagents = list("sal_acid" = 1, "lithium" = 1, "aluminum" = 1, "bromine" = 1, "ammonia" = 1)
	result_amount = 5

//Oxygen Loss////
//Tier 3////////


/datum/reagent/oxycocetosmo
	name = "Oxycocet Osmo"
	id = "oxycocetosmo"
	description = "Oxycocet Osmo is a very effective respiratory stimulant that is about 2.5x more effective then regular Oxycocet."
	reagent_state = LIQUID
	color = "#1f3d42"
	metabolization_rate = 0.25
/datum/reagent/oxycocetosmo/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.adjustOxyLoss(-25*REM)
	..()
	return
/datum/chemical_reaction/oxycocetosmo
	name = "Oxycocet Osmo"
	id = "oxycocetosmo"
	result = "oxycocetosmo"
	required_reagents = list("sal_acid" = 1, "lithium" = 1, "aluminum" = 1, "bromine" = 1, "ammonia" = 1)
	result_amount = 5

//Oxygen Loss////
//Tier 4////////

datum/reagent/perfluorodecalin
	name = "Perfluorodecalin"
	id = "perfluorodecalin"
	description = "This experimental perfluoronated solvent has applications in liquid breathing and tissue oxygenation. Use with caution."
	reagent_state = LIQUID
	color = "#C8A5DC"
	metabolization_rate = 0.1
datum/reagent/perfluorodecalin/on_mob_life(var/mob/living/carbon/human/M as mob)
	if(!M) M = holder.my_atom
	M.adjustOxyLoss(-45*REM)
	M.silent = max(M.silent, 5)
	if(M.losebreath >= 4)
		M.losebreath -= 4
	..()
	return
/datum/chemical_reaction/perfluorodecalin
	name = "Perfluorodecalin"
	id = "perfluorodecalin"
	result = "perfluorodecalin"
	required_reagents = list("hydrogen" = 1, "fluorine" = 1, "oil" = 1)
	result_amount = 3
	min_temp = 517

//Oxygen Loss////////////////
//Tier 5 (Unlisted Recipe)//

datum/reagent/perfluorodecalindx
	name = "Perfluorodecalin DX"
	id = "perfluorodecalindx"
	description = "Perfluorodecalin DX is an experimental drug designed by the sol government to allow for short peorids without oxygen. Very very addictive."
	reagent_state = LIQUID
	color = "#87bcc5"
	metabolization_rate = 0.085
	overdose_threshold = 20
	addiction_threshold = 10
datum/reagent/perfluorodecalindx/on_mob_life(var/mob/living/carbon/human/M as mob)
	if(!M) M = holder.my_atom
	M.adjustOxyLoss(-300*REM)
	M.adjustBrainLoss(0.05*REM)
	M.silent = max(M.silent, 25)
	if(M.losebreath >= 4)
		M.losebreath -= 10
	..()
	return
/datum/reagent/perfluorodecalindx/overdose_process(var/mob/living/M as mob)
	if(prob(40))
		M.adjustBrainLoss(2*REM)
		M.adjustInternalBurn(2*REM)
		M.losebreath++
	..()
	return
/datum/reagent/perfluorodecalindx/addiction_act_stage1(var/mob/living/M as mob)
	if(prob(40))
		M.adjustInternalBurn(0.5*REM)
		M.losebreath += 4
	..()
	return
/datum/reagent/perfluorodecalindx/addiction_act_stage2(var/mob/living/M as mob)
	if(prob(50))
		M.adjustInternalBurn(1*REM)
		M.adjustToxLoss(1*REM)
		M.losebreath += 8
	..()
	return
/datum/reagent/perfluorodecalindx/addiction_act_stage3(var/mob/living/M as mob)
	if(prob(60))
		M.adjustInternalBurn(2*REM)
		M.adjustToxLoss(2*REM)
		M.losebreath += 12
	..()
	return
/datum/reagent/perfluorodecalindx/addiction_act_stage4(var/mob/living/M as mob)
	if(prob(70))
		M.adjustInternalBurn(3*REM)
		M.adjustToxLoss(3*REM)
		M.losebreath += 12
	..()
	return
/datum/chemical_reaction/perfluorodecalindx
	name = "Perfluorodecalin DX"
	id = "perfluorodecalindx"
	result = "perfluorodecalindx"
	required_reagents = list("hydrogen" = 1, "fluorine" = 1, "oil" = 1)
	result_amount = 3
	min_temp = 670

//Brute Damage////
//Tier 1////////

/datum/reagent/bicaridine
	name = "Bicaridine"
	id = "bicaridine"
	description = "Bicaridine is an analgesic medication and can be used to treat blunt trauma."
	reagent_state = LIQUID
	color = "#d16023"
	metabolization_rate = 0.3
/datum/reagent/bicaridine/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(prob(99))
		M.adjustBruteLoss(-1.0*REM)
	..()
	return
/datum/chemical_reaction/bicaridine
	name = "Bicaridine"
	id = "bicaridine"
	result = "bicaridine"
	required_reagents = list("sal_acid" = 1, "lithium" = 1, "aluminum" = 1, "bromine" = 1, "ammonia" = 1)
	result_amount = 5

//Brute Damage////
//Tier 2////////

/datum/reagent/bretylol
	name = "Bretylol"
	id = "bretylol"
	description = "bretylol is an improved version of Bicardine. It uses a dual release system to cure brunt trauma up to three times faster!"
	reagent_state = LIQUID
	color = "#93451a"
	overdose_threshold = 30
/datum/reagent/bretylol/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(prob(99))
		M.adjustBruteLoss(-1.5*REM)
	if(prob(44))
		M.adjustBruteLoss(-2.5*REM)
	..()
	return
/datum/chemical_reaction/bretylol
	name = "Bretylol"
	id = "bretylol"
	result = "bretylol"
	required_reagents = list("sal_acid" = 1, "lithium" = 1, "aluminum" = 1, "bromine" = 1, "ammonia" = 1)
	result_amount = 5

//Stimulant (Nervous System & Heart)////
//Tier 5 (Special Drug)////////////////

/datum/reagent/ephedrine
	name = "Ephedrine"
	id = "ephedrine"
	description = "Ephedrine is a plant-derived stimulant."
	reagent_state = LIQUID
	color = "#C8A5DC"
	metabolization_rate = 0.3
	overdose_threshold = 45
	addiction_threshold = 30
	shock_reduction = 5
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
		M.adjustToxLoss(1*REM)
		M.losebreath += 2
	..()
	return
/datum/reagent/ephedrine/addiction_act_stage2(var/mob/living/M as mob)
	if(prob(33))
		M.adjustToxLoss(1.5*REM)
		M.losebreath += 2
	..()
	return
/datum/reagent/ephedrine/addiction_act_stage3(var/mob/living/M as mob)
	if(prob(33))
		M.adjustToxLoss(2*REM)
		M.losebreath += 3
	..()
	return
/datum/reagent/ephedrine/addiction_act_stage4(var/mob/living/M as mob)
	if(prob(33))
		M.adjustToxLoss(2.5*REM)
		M.losebreath += 4
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
//Tier 5 (Special Drug)////////////////

/datum/reagent/crystodigin
	name = "Crystodigin"
	id = "crystodigin"
	description = "Crystodigin is the next step up in stimulants. This powerful stimulant should be used with caution."
	reagent_state = LIQUID
	color = "#9d65bd"
	metabolization_rate = 0.65
	overdose_threshold = 25
	addiction_threshold = 18
	shock_reduction = 15
/datum/reagent/crystodigin/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.AdjustParalysis(-3)
	M.AdjustWeakened(-3)
	M.AdjustStunned (-4)
	M.adjustOxyLoss(-1)
	return
/datum/reagent/crystodigin/overdose_process(var/mob/living/M as mob) //May RNGesus be with you
	if(prob(33))
		M.adjustToxLoss(1*REM)
		M.losebreath++
	if(prob(1))
		M.visible_message("<span class='danger'>[M] starts having a seizure!</span>", "<span class='danger'>You have a seizure!</span>")
		M.Paralyse(5)
		M.jitteriness = 1000
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

//Stimulant (Nervous System & Heart)////
//Tier 5 (Special Drug)////////////////

/datum/reagent/methylprednisolone
	name = "Methylprednisolone"
	id = "methylprednisolone"
	description = "Methylprednisolone is the strongest legal stimulant. This drug is extremely addictive."
	reagent_state = LIQUID
	color = "#9d65bd"
	metabolization_rate = 0.65
	overdose_threshold = 15
	addiction_threshold = 5
	shock_reduction = 20
/datum/reagent/methylprednisolone/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.AdjustParalysis(-3)
	M.AdjustWeakened(-3)
	M.AdjustStunned (-4)
	M.adjustOxyLoss(-1)
	return
/datum/reagent/methylprednisolone/overdose_process(var/mob/living/M as mob) //May RNGesus be with you
	if(prob(50))
		M.adjustToxLoss(0.5*REM)
		M.losebreath++
	if(prob(10))
		M.visible_message("<span class='danger'>[M] starts having a seizure!</span>", "<span class='danger'>You have a seizure!</span>")
		M.Paralyse(5)
		M.jitteriness = 1000
	if(volume >=19)
		var/mob/living/carbon/human/H = M
		if(!H.heart_attack)
			H.heart_attack = 1 // rip in pepperoni kek kek kek
	..()
	return
/datum/reagent/methylprednisolone/addiction_act_stage1(var/mob/living/M as mob)
	if(prob(33))
		M.adjustToxLoss(2*REM)
		M.losebreath += 2
	..()
	return
/datum/reagent/methylprednisolone/addiction_act_stage2(var/mob/living/M as mob)
	if(prob(33))
		M.adjustToxLoss(3*REM)
		M.losebreath += 3
	..()
	return
/datum/reagent/methylprednisolone/addiction_act_stage3(var/mob/living/M as mob)
	if(prob(33))
		M.adjustToxLoss(4*REM)
		M.losebreath += 4
	if(prob(1))
		var/mob/living/carbon/human/H = M
		if(!H.heart_attack)
			H.heart_attack = 1 // rip in pepperoni
	..()
	return
/datum/reagent/methylprednisolone/addiction_act_stage4(var/mob/living/M as mob)
	if(prob(33))
		M.adjustToxLoss(5*REM)
		M.losebreath += 5
	if(prob(1))
		var/mob/living/carbon/human/H = M
		if(!H.heart_attack)
			H.heart_attack = 1 // rip in pepperoni
	..()
	return
/datum/chemical_reaction/methylprednisolone
	name = "Methylprednisolone"
	id = "methylprednisolone"
	result = "methylprednisolone"
	required_reagents = list("sal_acid" = 1, "lithium" = 1, "aluminum" = 1, "bromine" = 1, "ammonia" = 1)
	result_amount = 5

#define SOLID 1
#define LIQUID 2
#define GAS 3
#define REM REAGENTS_EFFECT_MULTIPLIER

/////////////////////////////////////////////////////////////////////
//         Base-Chems Are Building Blocks For Other Chems         //
 //          Three Tiers Of Fun. Tier 1, Tier 2, Tier 3.        //
  //////////////////////////////////////////////////////////////

//TIER ONE//

/datum/reagent/acetic_acid
	name = "Acetic acid"
	id = "acetic_acid"
	description = "Acetic acid is a weak acid that is used for basic reactions. Also known as vinegar."
	reagent_state = LIQUID
	color = "#6E3B08" // rgb: 110, 59, 8
/datum/chemical_reaction/acetic_acid
	name = "Acetic acid"
	id = "acetic_acid"
	result = "acetic_acid"
	required_reagents = list("sacid" = 1, "water" = 5)
	result_amount = 4


/datum/reagent/adp
	name = "Adenosine Diphosphate"
	id = "adp"
	description = "A simple two phosphate sugar that the human body uses for energy.Its pure human energy."
	reagent_state = SOLID
	color = "#FFFFFF" // rgb: 255, 255, 255
	overdose_threshold = 150 // WHY WOULD YOU EAT THIS! FUCKING WHY? JUST TAKE DRUGS.
	affect_blood(var/mob/living/M as mob)
		if(prob(7))
			M.AdjustParalysis(-1)
			M.AdjustStunned(-1)
			M.AdjustWeakened(-1)
		if(current_cycle >= 65)
			M.jitteriness += 10
		..()
		return
	overdose_process(var/mob/living/M as mob)
		if(volume > 150)
			M.Paralyse(1)
			if(prob(7))
				M.adjustToxLoss(rand(1,2))
		..()
		return
/datum/chemical_reaction/adp
	name = "Adenosine Diphosphate"
	id = "adp"
	result = "adp"
	required_reagents = list("water" = 1, "phosphorus" = 2, "sugar" = 2)
	result_amount = 4 //one sugar is lost in the chemical reaction.. Science!


/datum/reagent/atp
	name = "Adenosine Triphosphate"
	id = "atp"
	description = "A simple three phosphate sugar that the human body uses for energy.Its pure human energy."
	reagent_state = SOLID
	color = "#FFFFFF" // rgb: 255, 255, 255
	overdose_threshold = 130 //WHY IN THE LIVING..... SEE ADP^
	affect_blood(var/mob/living/M as mob)
		if(prob(11))
			M.AdjustParalysis(-1)
			M.AdjustStunned(-1)
			M.AdjustWeakened(-1)
		if(current_cycle >= 55)
			M.jitteriness += 15
		..()
		return
	overdose_process(var/mob/living/M as mob)
		if(volume > 230)
			M.Paralyse(1)
			if(prob(11))
				M.adjustToxLoss(rand(1,2))
		..()
		return
/datum/chemical_reaction/atp
	name = "Adenosine Triphosphate"
	id = "atp"
	result = "atp"
	required_reagents = list("water" = 1, "phosphorus" = 3, "adp" = 1)
	result_amount = 3 //Loses the ADP in the process.... Science!


/datum/reagent/carbolic_acid
	name = "Carbolic Acid"
	id = "carbolic_acid"
	description = "This is a useful building block in organic chemistry."
	reagent_state = LIQUID
	color = "#525050"
/datum/chemical_reaction/carbolic_acid
	name = "Carbolic Acid"
	id = "carbolic_acid"
	result = "carbolic_acid"
	required_reagents = list("water" = 1, "chlorine" = 1, "oil" = 1)
	result_amount = 3


/datum/reagent/fiber
	name = "Fiber" //Gotta Shit Fast
	id = "fiber"
	description = "Part of a healthy diet!"
	reagent_state = SOLID
	color = "#6E3B08" // rgb: 110, 59, 8
/datum/chemical_reaction/fiber
	name = "Fiber"
	id = "fiber"
	result = "fiber"
	required_reagents = list("water" = 3, "copper" = 1, "tungsten" = 1)
	result_amount = 3
	min_temp = 400


/datum/reagent/glucosesolution
	name = "Glucose Solution"
	id = "glucosesolution"
	description = "A simple sugarwater solution."
	reagent_state = LIQUID
	color = "#6E3B08" // rgb: 110, 59, 8
	metabolization_rate = 0.15
/datum/reagent/salinesolution/affect_blood(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(prob(10))
		M.adjustBruteLoss(-0.25*REM)
	..()
	return
/datum/chemical_reaction/glucosesolution
	name = "Glucose Solution"
	id = "glucosesolution"
	result = "glucosesolution"
	required_reagents = list("sugar" = 1, "water" = 2)
	result_amount = 3


/datum/reagent/hydrofluoride
	name = "Hydrofluoride"
	id = "hydrofluoride"
	description = "A mix of hydrogen and fluoride."
	reagent_state = GAS
	color = "#493062"
/datum/chemical_reaction/hydrofluorine
	name = "Hydrofluorine"
	id = "hydrofluoride"
	result = "hydrofluorine"
	required_reagents = list("hydrogen" = 1, "fluorine" = 1)
	result_amount = 2


/datum/reagent/iodine
	name = "Iodine"
	id = "iodine"
	description = "A purple gaseous element."
	reagent_state = GAS
	color = "#493062"
/datum/chemical_reaction/iodine
	name = "Iodine"
	id = "iodine"
	result = "iodine"
	required_reagents = list("water" = 2, "hydrogen" = 1, "sacid" = 1)
	result_amount = 3
	mix_message = "The mixture bubbles and gives off an unpleasant medicinal odor."


/datum/reagent/reiorn
	name = "Refined Iron"
	id = "reiron"
	description = "Refined iron is lighter and stronger then standard iron."
	reagent_state = SOLID
	color = "#6E3B08" // rgb: 110, 59, 8
/datum/chemical_reaction/reiron
	name = "Refined Iron"
	id = "reiron"
	result = "reiron"
	required_reagents = list("iron" = 3, "oxygen" = 1)
	result_amount = 2
	min_temp = 396


/datum/reagent/salinesolution
	name = "Saline Solution"
	id = "salinesolution"
	description = "A simple saltwater solution."
	reagent_state = LIQUID
	color = "#6E3B08" // rgb: 110, 59, 8
	metabolization_rate = 0.15
/datum/reagent/salinesolution/affect_blood(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	if(prob(10))
		M.adjustFireLoss(-0.25*REM)
	..()
	return


/datum/reagent/sludgee
	name = "Sludge"
	id = "sludgee"
	description = "A wonderful mix of water and what?."
	reagent_state = LIQUID
	color = "#525050"
/datum/reagent/sludgee/affect_blood(var/mob/living/M as mob)
		if(!M) M = holder.my_atom
		M.apply_effect(0.5*REM,IRRADIATE,0)
/datum/chemical_reaction/sludgee
	name = "Sludge"
	id = "sludgee"
	result = "sludgee"
	required_reagents = list("water" = 2, "radium" = 1, "tungsten" = 1)
	result_amount = 3


/datum/reagent/trihydrocarbon
	name = "Tri-Hydrocarbon"
	id = "trihydrocarbon"
	description = "A carbon based mass that is used to make charcoal."
	reagent_state = SOLID
	color = "#6E3B08" // rgb: 110, 59, 8
/datum/chemical_reaction/trihydrocarbon
	name = "Tri-Hydrocarbon"
	id = "trihydrocarbon"
	result = "trihydrocarbon"
	required_reagents = list("hydrogen" = 3, "carbon" = 1)
	result_amount = 3
	min_temp = 400

///////////////////
//   TIER TWO    //
///////////////////


#define SOLID 1
#define LIQUID 2
#define GAS 3
#define REM REAGENTS_EFFECT_MULTIPLIER

///////////////////////////////////////////////////////////////////
//Base-Chems Are Building Blocks For Other Chems//3 Tiers Of Fun.//
///////////////////////////////////////////////////////////////////////////////////////////////////
//-----------------------------------------------------------------------------------------------//
//Tier One (Solid(a), Liquid(b), Gas(c), Heated/Cooled(d/e), Phoron(f)) (Effect(1), No Effect(2))//
//-----------------------------------------------------------------------------------------------//
///////////////////////////////////////////////////////////////////////////////////////////////////

//T1-1a: Solid, Effect//
/datum/reagent/atp
	name = "Adenosine Triphosphate"
	id = "atp"
	description = "A simple three phosphate sugar that the human body uses for energy.Its pure human energy."
	reagent_state = SOLID
	color = "#FFFFFF" // rgb: 255, 255, 255
	overdose_threshold = 145 // Hyperglycaemic shock (this is //pure// thats why the OD is 145)
	on_mob_life(var/mob/living/M as mob)
		if(prob(10))
			M.AdjustParalysis(-1)
			M.AdjustStunned(-1)
			M.AdjustWeakened(-1)
		if(current_cycle >= 70)
			M.jitteriness += 10
		..()
		return

	overdose_process(var/mob/living/M as mob)
		if(volume > 145)
			M.Paralyse(1)
			if(prob(8))
				M.adjustToxLoss(rand(1,2))
		..()
		return

//T1-1a: Solid, Effect//
	name = "Adenosine Diphosphate"
	id = "adp"
	description = "A simple two phosphate sugar that the human body uses for energy.Its pure human energy."
	reagent_state = SOLID
	color = "#FFFFFF" // rgb: 255, 255, 255
	overdose_threshold = 165 // Hyperglycaemic shock (this is //pure// thats why the OD is 165)
	on_mob_life(var/mob/living/M as mob)
		if(prob(7))
			M.AdjustParalysis(-1)
			M.AdjustStunned(-1)
			M.AdjustWeakened(-1)
		if(current_cycle >= 70)
			M.jitteriness += 10
		..()
		return

	overdose_process(var/mob/living/M as mob)
		if(volume > 165)
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
	result_amount = 4

//T1-1a: Liquid, No Effect//
/datum/reagent/acetic_acid
	name = "Acetic acid"
	id = "acetic_acid"
	description = "Acetic acid is a weak acid that is used for basic reactions. Also known as vinegar."
	color = "#6E3B08" // rgb: 110, 59, 8	overdose_threshold = 120 // Zinc Poisioning
	on_mob_life(var/mob/living/M as mob)

/datum/chemical_reaction/acetic_acid
	name = "Acetic acid"
	id = "acetic_acid"
	result = "acetic_acid"
	required_reagents = list("sacid" = 1, "sodium" = 1, "water" = 4)
	result_amount = 4

//T1-2b: Liquid, No Effect//
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
	mix_message = "The mixture bubbles and gives off an unpleasant medicinal odor."

//T1-2c: Gas, No Effect//
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
	required_reagents = list("water" = 1, "hydrogen" = 1, "sacid" = 1)
	result_amount = 2
	mix_message = "The mixture bubbles and gives off an unpleasant medicinal odor."

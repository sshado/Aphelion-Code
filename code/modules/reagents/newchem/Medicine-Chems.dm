#define SOLID 1
#define LIQUID 2
#define GAS 3

#define REM REAGENTS_EFFECT_MULTIPLIER

//////////////////////////////////////
//MEDICINES//
/////////////////////////////////////

/datum/chemical_reaction/anti_toxin
	name = "Dylovene"
	id = "anti_toxin"
	description = "Dylovene is a broad-spectrum antitoxin. Reduces hallucinations faster than charcoal"
	reagent_state = LIQUID
	color = "#00A000"
	scannable = 1

/datum/reagent/dylovene/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien != IS_DIONA)
		M.drowsyness = max(0, M.drowsyness - 6 * removed)
		M.hallucination = max(0, M.hallucination - 9 * removed)
		M.adjustToxLoss(-4 * removed)

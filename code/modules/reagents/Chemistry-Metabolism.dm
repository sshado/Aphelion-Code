//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

///////////////////////////////////////////////////////////////////////////////////
datum/reagent
	var/overdose_threshold = 0
	var/addiction_threshold = 0
	var/addiction_stage = 0
	var/overdosed = 0 // You fucked up and this is now triggering it's overdose effects, purge that shit quick.
	var/current_cycle = 0
datum/reagents
	var/metabolism = REM // This would be 0.2 normally
	var/affect_blood_met = 0
	var/affect_touch_met = 0
	var/affect_ingest_met = 0
	var/dose = 0
	var/max_dose = 0
	var/volume = 0
	var/overdose = 0
	var/affects_dead = 0
	var/affect_blood = 0
	var/affect_touch = 0
	var/affect_ingest = 0
	var/chem_temp = 300
	var/addiction_tick = 1
	var/list/datum/reagent/addiction_list = new/list()

datum/reagents/proc/metabolize(var/mob/M)
	if(M)
		if(!istype(M, /mob/living))		//Non-living mobs can't metabolize reagents, so don't bother trying (runtime safety check)
			return
		chem_temp = M.bodytemperature
		handle_reactions()
	for(var/A in reagent_list)
		var/datum/reagent/R = A
		if(!istype(R))
			continue
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			//Check if this mob's species is set and can process this type of reagent
			var/can_process = 0
			//If we somehow avoided getting a species or reagent_tag set, we'll assume we aren't meant to process ANY reagents (CODERS: SET YOUR SPECIES AND TAG!)
			if(H.species && H.species.reagent_tag)
				if((R.process_flags & SYNTHETIC) && (H.species.reagent_tag & PROCESS_SYN))		//SYNTHETIC-oriented reagents require PROCESS_SYN
					can_process = 1
				if((R.process_flags & ORGANIC) && (H.species.reagent_tag & PROCESS_ORG))		//ORGANIC-oriented reagents require PROCESS_ORG
					can_process = 1
				//Species with PROCESS_DUO are only affected by reagents that affect both organics and synthetics, like acid and hellwater
				if((R.process_flags & ORGANIC) && (R.process_flags & SYNTHETIC) && (H.species.reagent_tag & PROCESS_DUO))
					can_process = 1
			//If the mob can't process it, remove the reagent at it's normal rate without doing any addictions, overdoses, or on_mob_life() for the reagent
			if(can_process == 0)
				R.holder.remove_reagent(R.id, R.metabolization_rate)
				continue
		//We'll assume that non-human mobs lack the ability to process synthetic-oriented reagents (adjust this if we need to change that assumption)
		else
			if(R.process_flags == SYNTHETIC)
				R.holder.remove_reagent(R.id, R.metabolization_rate)
				continue
		//If you got this far, that means we can process whatever reagent this iteration is for. Handle things normally from here.
		if(M && R)
			if(R.volume >= R.overdose_threshold && !R.overdosed && R.overdose_threshold > 0)
				R.overdosed = 1
				M << "<span class = 'userdanger'>You feel like you took too much [R.name]!</span>"
				R.overdose_start(M)
			if(R.volume >= R.addiction_threshold && !is_type_in_list(R, addiction_list) && R.addiction_threshold > 0)
				var/datum/reagent/new_reagent = new R.type()
				addiction_list.Add(new_reagent)
			if(R.overdosed)
				R.overdose_process(M)
			if(is_type_in_list(R,addiction_list))
				for(var/datum/reagent/addicted_reagent in addiction_list)
					if(istype(R, addicted_reagent))
						addicted_reagent.addiction_stage = -15 // you're satisfied for a good while.
			R.on_mob_life(M)
	if(addiction_tick == 6)
		addiction_tick = 1
		for(var/A in addiction_list)
			var/datum/reagent/R = A
			if(M && R)
				if(R.addiction_stage <= 0)
					R.addiction_stage++
				if(R.addiction_stage > 0 && R.addiction_stage <= 10)
					R.addiction_act_stage1(M)
					R.addiction_stage++
				if(R.addiction_stage > 10 && R.addiction_stage <= 20)
					R.addiction_act_stage2(M)
					R.addiction_stage++
				if(R.addiction_stage > 20 && R.addiction_stage <= 30)
					R.addiction_act_stage3(M)
					R.addiction_stage++
				if(R.addiction_stage > 30 && R.addiction_stage <= 40)
					R.addiction_act_stage4(M)
					R.addiction_stage++
				if(R.addiction_stage > 40)
					M << "<span class = 'notice'>You feel like you've gotten over your need for [R.name].</span>"
					addiction_list.Remove(R)
	addiction_tick++
	update_total()

datum/reagents/proc/reagent_on_tick()
	for(var/datum/reagent/R in reagent_list)
		R.on_tick()
	return

// Called every time reagent containers process.
datum/reagent/proc/on_tick(var/data)
	return

// Called when the reagent container is hit by an explosion
datum/reagent/proc/on_ex_act(var/severity)
	return

// Called if the reagent has passed the overdose threshold and is set to be triggering overdose effects
datum/reagent/proc/overdose_process(var/mob/living/M as mob)
	return

datum/reagent/proc/overdose_start(var/mob/living/M as mob)
	return

datum/reagent/proc/addiction_act_stage1(var/mob/living/M as mob)
	if(prob(30))
		M << "<span class = 'notice'>You feel like some [name] right about now.</span>"
	return

datum/reagent/proc/addiction_act_stage2(var/mob/living/M as mob)
	if(prob(30))
		M << "<span class = 'notice'>You feel like you need [name]. You just can't get enough.</span>"
	return

datum/reagent/proc/addiction_act_stage3(var/mob/living/M as mob)
	if(prob(30))
		M << "<span class = 'danger'>You have an intense craving for [name].</span>"
	return

datum/reagent/proc/addiction_act_stage4(var/mob/living/M as mob)
	if(prob(30))
		M << "<span class = 'danger'>You're not feeling good at all! You really need some [name].</span>"
	return

/datum/reagent/proc/reagent_deleted()
	return

/datum/reagents/metabolism
	var/metabolism_class //CHEM_affect_touch, CHEM_BLOOD, or CHEM_BLOOD
	var/mob/living/carbon/parent

/datum/reagents/metabolism/New(var/max = 100, mob/living/carbon/parent_mob, var/met_class)
	..(max, parent_mob)

	metabolism_class = met_class
	if(istype(parent_mob))
		parent = parent_mob

	var/metabolism_type = 0 //non-human mobs
	if(ishuman(parent))
		var/mob/living/carbon/human/H = parent
		metabolism_type = H.species.reagent_tag

	for(var/datum/reagent/current in reagent_list)
		current.on_mob_life(parent, metabolism_type, metabolism_class)
	update_total()

///////////////////////////////////////////////////////////////////////////

/datum/reagent
	var/metabolism = REM // This would be 0.2 normally
	var/affect_blood_met = 0
	var/affect_touch_met = 0
	var/affect_ingest_met = 0
	var/dose = 0
	var/max_dose = 0
	var/overdose = 0
	var/affects_dead = 0
	var/affect_blood = 0
	var/affect_touch = 0
	var/affect_ingest = 0


/datum/reagent/proc/remove_self(var/amount) // Shortcut
	holder.remove_reagent(id, amount)

/datum/reagent/proc/on_mob_live(var/mob/living/carbon/M, var/alien, var/location) // Currently, on_mob_life is called on carbons. Any interaction with non-carbon mobs (lube) will need to be done in affect_touch_mob.
	if(!istype(M))
		return
	if(!affects_dead && M.stat == DEAD)
		return
	if(overdose && (dose > overdose) && (location != CHEM_TOUCH))
		overdose(M, alien)
	var/removed = metabolism
	if(affect_blood_met && (location == affect_blood))
		removed = affect_blood_met
	if(affect_touch_met && (location == affect_touch))
		removed = affect_touch_met
	if(affect_ingest_met && (location == affect_ingest))
		removed = affect_ingest_met
	removed = min(removed, volume)
	max_dose = max(volume, max_dose)
	dose = min(dose + removed, max_dose)
	if(removed >= (metabolism * 0.1) || removed >= 0.1) // If there's too little chemical, don't affect the mob, just remove it
		switch(location)
			if(CHEM_TOUCH)
				affect_touch(M, alien, removed)
			if(CHEM_INGEST)
				affect_ingest(M, alien, removed)
			if(CHEM_BLOOD)
				affect_blood(M, alien, removed)
	remove_self(removed)
	return

/datum/reagent/proc/blood(var/mob/living/carbon/M, var/alien, var/removed)
	return

/datum/reagent/proc/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	affect_blood(M, alien, removed * 0.5)
	return

/datum/reagent/proc/affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
	return

/datum/reagent/proc/affect_ingest(var/mob/living/carbon/M, var/alien, var/removed)
	affect_ingest(M, alien, removed * 0.5)
	return

/datum/reagent/proc/initialize_data(var/newdata) // Called when the reagent is created.
	if(!isnull(newdata))
		data = newdata
	return

/datum/reagent/proc/mix_data(var/newdata, var/newamount) // You have a reagent with data, and new reagent with its own data get added, how do you deal with that?
	return

/datum/reagent/proc/get_data() // Just in case you have a reagent that handles data differently.
	if(data && istype(data, /list))
		return data.Copy()
	else if(data)
		return data
	return null

/datum/reagent/Destroy() // This should only be called by the holder, so it's already handled clearing its references
	..()
	holder = null

/* DEPRECATED - TODO: REMOVE EVERYWHERE */

/////////////////////////////////////////////////////////////

/datum/reagents

/datum/reagents/New(var/max = 100, atom/A = null)
	maximum_volume = max
	my_atom = A

	//I dislike having these here but map-objects are initialised before world/New() is called. >_>
	if(!chemical_reagents_list)
		//Chemical Reagents - Initialises all /datum/reagent into a list indexed by reagent id
		var/paths = typesof(/datum/reagent) - /datum/reagent
		chemical_reagents_list = list()
		for(var/path in paths)
			var/datum/reagent/D = new path()
			if(!D.name)
				continue
			chemical_reagents_list[D.id] = D

	if(!chemical_reactions_list)
		//Chemical Reactions - Initialises all /datum/chemical_reaction into a list
		// It is filtered into multiple lists within a list.
		// For example:
		// chemical_reaction_list["phoron"] is a list of all reactions relating to phoron

		var/paths = typesof(/datum/chemical_reaction) - /datum/chemical_reaction
		chemical_reactions_list = list()

		for(var/path in paths)

			var/datum/chemical_reaction/D = new path()
			var/list/reaction_ids = list()

			if(D.required_reagents && D.required_reagents.len)
				for(var/reaction in D.required_reagents)
					reaction_ids += reaction

			// Create filters based on each reagent id in the required reagents list
			for(var/id in reaction_ids)
				if(!chemical_reactions_list[id])
					chemical_reactions_list[id] = list()
				chemical_reactions_list[id] += D
				break // Don't bother adding ourselves to other reagent ids, it is redundant.

/datum/reagents/Destroy()
	..()
	for(var/datum/reagent/R in reagent_list)
		qdel(R)
	reagent_list.Cut()
	reagent_list = null
	if(my_atom && my_atom.reagents == src)
		my_atom.reagents = null

/* Internal procs */

/datum/reagents/proc/get_free_space() // Returns free space.
	return maximum_volume - total_volume

/datum/reagents/proc/get_master_reagent() // Returns reference to the reagent with the biggest volume.
	var/the_reagent = null
	var/the_volume = 0

	for(var/datum/reagent/A in reagent_list)
		if(A.volume > the_volume)
			the_volume = A.volume
			the_reagent = A

	return the_reagent

/datum/reagents/proc/delete()
	for(var/datum/reagent/R in reagent_list)
		R.holder = null
	if(my_atom)
		my_atom.reagents = null

/datum/reagents/proc/handle_reaction()
	if(!my_atom) // No reactions in temporary holders
		return
	if(my_atom.flags & NOREACT) // No reactions here
		return

	var/reaction_occured = 0
	do
		reaction_occured = 0
		for(var/datum/reagent/R in reagent_list)
			for(var/datum/chemical_reaction/C in chemical_reactions_list[R.id])
				var/reagents_suitable = 1
				for(var/B in C.required_reagents)
					if(!has_reagent(B, C.required_reagents[B]))
						reagents_suitable = 0
				for(var/B in C.catalysts)
					if(!has_reagent(B, C.catalysts[B]))
						reagents_suitable = 0
				for(var/B in C.inhibitors)
					if(has_reagent(B, C.inhibitors[B]))
						reagents_suitable = 0

				if(!reagents_suitable || !C.can_happen(src))
					continue

				var/use = -1
				for(var/B in C.required_reagents)
					if(use == -1)
						use = get_reagent_amount(B) / C.required_reagents[B]
					else
						use = min(use, get_reagent_amount(B) / C.required_reagents[B])

				var/newdata = C.send_data(src) // We need to get it before reagents are removed. See blood paint.
				for(var/B in C.required_reagents)
					remove_reagent(B, use * C.required_reagents[B], safety = 1)

				if(C.result)
					add_reagent(C.result, C.result_amount * use, newdata)

				if(!ismob(my_atom) && C.mix_message)
					var/list/seen = viewers(4, get_turf(my_atom))
					for(var/mob/M in seen)
						M << "<span class='notice'>\icon[my_atom] [C.mix_message]</span>"
					playsound(get_turf(my_atom), 'sound/effects/bubbles.ogg', 80, 1)

				C.on_reaction(src, C.result_amount * use)
				reaction_occured = 1
	while(reaction_occured)
	update_total()
	return

/* Holder-to-holder and similar procs */


/datum/reagents/proc/trans_to_holder(var/datum/reagents/target, var/amount = 1, var/multiplier = 1, var/copy = 0) // Transfers [amount] reagents from [src] to [target], multiplying them by [multiplier]. Returns actual amount removed from [src] (not amount transferred to [target]).
	if(!target || !istype(target))
		return

	amount = max(0, min(amount, total_volume, target.get_free_space() / multiplier))

	if(!amount)
		return

	var/part = amount / total_volume

	for(var/datum/reagent/current in reagent_list)
		var/amount_to_transfer = current.volume * part
		target.add_reagent(current.id, amount_to_transfer * multiplier, current.get_data(), safety = 1) // We don't react until everything is in place
		if(!copy)
			remove_reagent(current.id, amount_to_transfer, 1)

	if(!copy)
		handle_reactions()
	target.handle_reactions()
	return amount

/* Holder-to-atom and similar procs */

// When applying reagents to an atom externally, affect_touch() is called to trigger any on-affect_touch effects of the reagent.
// This does not handle transferring reagents to things.
// For example, splashing someone with water will get them wet and extinguish them if they are on fire,
// even if they are wearing an impermeable suit that prevents the reagents from contacting the skin.
/datum/reagents/proc/affect_touch(var/atom/target)
	if(ismob(target))
		affect_touch_mob(target)
	if(isturf(target))
		affect_touch_turf(target)
	if(isobj(target))
		affect_touch_obj(target)
	return

/datum/reagents/proc/affect_touch_mob(var/mob/target)
	if(!target || !istype(target))
		return

	for(var/datum/reagent/current in reagent_list)
		current.affect_touch_mob(target, current.volume)

	update_total()

/datum/reagents/proc/affect_touch_turf(var/turf/target)
	if(!target || !istype(target))
		return

	for(var/datum/reagent/current in reagent_list)
		current.affect_touch_turf(target, current.volume)

	update_total()

/datum/reagents/proc/affect_touch_obj(var/obj/target)
	if(!target || !istype(target))
		return

	for(var/datum/reagent/current in reagent_list)
		current.affect_touch_obj(target, current.volume)

	update_total()

// Attempts to place a reagent on the mob's skin.
// Reagents are not guaranteed to transfer to the target.
// Do not call this directly, call trans_to() instead.
/datum/reagents/proc/splash_mob(var/mob/target, var/amount = 1, var/copy = 0)
	var/perm = 1
	if(isliving(target)) //will we ever even need to tranfer reagents to non-living mobs?
		var/mob/living/L = target
		perm = L.reagent_permeability()
	return trans_to_mob(target, amount, CHEM_TOUCH, perm, copy)

/datum/reagents/proc/splash(var/atom/target, var/amount = 1, var/multiplier = 1, var/copy = 0)
	trans_to(target, amount, multiplier, copy)


/datum/reagents/proc/trans_to_mob(var/mob/target, var/amount = 1, var/type = CHEM_BLOOD, var/multiplier = 1, var/copy = 0) // Transfer after checking into which holder...
	if(!target || !istype(target))
		return
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		if(type == CHEM_TOUCH)
			var/datum/reagents/R = C.touching
			return trans_to_holder(R, amount, multiplier, copy)
		if(type == CHEM_INGEST)
			var/datum/reagents/R = C.ingested
			return trans_to_holder(R, amount, multiplier, copy)
		if(type == CHEM_BLOOD)
			var/datum/reagents/R = C.bloodstr
			return trans_to_holder(R, amount, multiplier, copy)
	else
		var/datum/reagents/R = new /datum/reagents(amount)
		. = trans_to_holder(R, amount, multiplier, copy)
		R.affect_touch_mob(target)

/datum/reagents/proc/trans_to_turf(var/turf/target, var/amount = 1, var/multiplier = 1, var/copy = 0) // Turfs don't have any reagents (at least, for now). Just affect_touch it.
	if(!target)
		return

	var/datum/reagents/R = new /datum/reagents(amount * multiplier)
	. = trans_to_holder(R, amount, multiplier, copy)
	R.affect_touch_turf(target)
	return

/datum/reagents/proc/trans_to_obj(var/turf/target, var/amount = 1, var/multiplier = 1, var/copy = 0) // Objects may or may not; if they do, it's probably a beaker or something and we need to transfer properly; otherwise, just affect_touch.
	if(!target)
		return

	if(!target.reagents)
		var/datum/reagents/R = new /datum/reagents(amount * multiplier)
		. = trans_to_holder(R, amount, multiplier, copy)
		R.affect_touch_obj(target)
		return

	return trans_to_holder(target.reagents, amount, multiplier, copy)

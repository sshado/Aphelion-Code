#define SOLID 1
#define LIQUID 2
#define GAS 3

#define REM REAGENTS_EFFECT_MULTIPLIER

/datum/reagent/stabilizing_agent
	name = "Stabilizing Agent"
	id = "stabilizing_agent"
	description = "A chemical that stabilises normally volatile compounds, preventing them from reacting immediately."
	reagent_state = LIQUID
	color = "#FFFF00"

/datum/chemical_reaction/stabilizing_agent
	name = "stabilizing_agent"
	id = "stabilizing_agent"
	result = "stabilizing_agent"
	required_reagents = list("iron" = 1, "oxygen" = 1, "hydrogen" = 1)
	result_amount = 2
	mix_message = "The mixture becomes a yellow liquid!"

/datum/reagent/clf3
	name = "Chlorine Trifluoride"
	id = "clf3"
	description = "An extremely volatile substance, handle with the utmost care."
	reagent_state = LIQUID
	color = "#FF0000"
	metabolization_rate = 4

/datum/reagent/sorium
	name = "Sorium"
	id = "sorium"
	description = "Sends everything flying from the detonation point."
	reagent_state = LIQUID
	color = "#FFA500"

/datum/chemical_reaction/sorium
	name = "Sorium"
	id = "sorium"
	result = "sorium"
	required_reagents = list("mercury" = 1, "oxygen" = 1, "nitrogen" = 1, "carbon" = 1)
	result_amount = 4

/datum/chemical_reaction/sorium_vortex
	name = "sorium_vortex"
	id = "sorium_vortex"
	result = null
	required_reagents = list("sorium" = 1)
	min_temp = 474

/datum/reagent/liquid_dark_matter
	name = "Liquid Dark Matter"
	id = "liquid_dark_matter"
	description = "Sucks everything into the detonation point."
	reagent_state = LIQUID
	color = "#800080"

/datum/chemical_reaction/liquid_dark_matter
	name = "Liquid Dark Matter"
	id = "liquid_dark_matter"
	result = "liquid_dark_matter"
	required_reagents = list("plasma" = 1, "radium" = 1, "carbon" = 1)
	result_amount = 3

/datum/chemical_reaction/ldm_vortex
	name = "LDM Vortex"
	id = "ldm_vortex"
	result = null
	required_reagents = list("liquid_dark_matter" = 1)
	min_temp = 474

/datum/reagent/blackpowder
	name = "Black Powder"
	id = "blackpowder"
	description = "Explodes. Violently."
	reagent_state = LIQUID
	color = "#000000"
	metabolization_rate = 0.05
	penetrates_skin = 1

/datum/chemical_reaction/blackpowder
	name = "Black Powder"
	id = "blackpowder"
	result = "blackpowder"
	required_reagents = list("saltpetre" = 1, "charcoal" = 1, "sulfur" = 1)
	result_amount = 3

/datum/chemical_reaction/blackpowder_explosion
	name = "Black Powder Kaboom"
	id = "blackpowder_explosion"
	result = null
	required_reagents = list("blackpowder" = 1)
	result_amount = 1
	min_temp = 474
	no_message = 1
	mix_sound = null

/*
/datum/reagent/blackpowder/on_ex_act()
	var/location = get_turf(holder.my_atom)
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(2, 1, location)
	s.start()
	sleep(rand(10,15))
	blackpowder_detonate(holder, volume)
	holder.remove_reagent("blackpowder", volume)
	return */

/datum/reagent/flash_powder
	name = "Flash Powder"
	id = "flash_powder"
	description = "Makes a very bright flash."
	reagent_state = LIQUID
	color = "#FFFF00"

/datum/chemical_reaction/flash_powder
	name = "Flash powder"
	id = "flash_powder"
	result = "flash_powder"
	required_reagents = list("aluminum" = 1, "potassium" = 1, "sulfur" = 1, "chlorine" = 1)
	result_amount = 3

/datum/chemical_reaction/flash_powder_flash
	name = "Flash powder activation"
	id = "flash_powder_flash"
	result = null
	required_reagents = list("flash_powder" = 1)
	min_temp = 374

/datum/chemical_reaction/flash_powder_flash/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(2, 1, location)
	s.start()
	for(var/mob/living/carbon/C in viewers(5, location))
		if(C.eyecheck())
			continue
		flick("e_flash", C.flash)
		if(get_dist(C, location) < 4)
			C.Weaken(5)
			continue
		C.Stun(5)

/datum/chemical_reaction/flash_powder/on_reaction(var/datum/reagents/holder, var/created_volume)
	if(holder.has_reagent("stabilizing_agent"))
		return
	var/location = get_turf(holder.my_atom)
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(2, 1, location)
	s.start()
	for(var/mob/living/carbon/C in viewers(5, location))
		if(C.eyecheck())
			continue
		flick("e_flash", C.flash)
		if(get_dist(C, location) < 4)
			C.Weaken(5)
			continue
		C.Stun(5)
	holder.remove_reagent("flash_powder", created_volume)

/datum/reagent/smoke_powder
	name = "Smoke Powder"
	id = "smoke_powder"
	description = "Makes a large cloud of smoke that can carry reagents."
	reagent_state = LIQUID
	color = "#808080"

/datum/chemical_reaction/smoke_powder
	name = "smoke_powder"
	id = "smoke_powder"
	result = "smoke_powder"
	required_reagents = list("stabilizing_agent" = 1, "potassium" = 1, "sugar" = 1, "phosphorus" = 1)
	result_amount = 3
	mix_message = "The mixture sets into a greyish powder!"

/datum/chemical_reaction/smoke
	name = "smoke"
	id = "smoke"
	result = null
	required_reagents = list("potassium" = 1, "sugar" = 1, "phosphorus" = 1)
	result_amount = 1
	mix_message = "The mixture quickly turns into a pall of smoke!"
	var/forbidden_reagents = list("sugar", "phosphorus", "potassium") //Do not transfer this stuff through smoke.

/datum/chemical_reaction/smoke/smoke_powder
	name = "smoke_powder_smoke"
	id = "smoke_powder_smoke"
	required_reagents = list("smoke_powder" = 1)
	min_temp = 374
	secondary = 1
	result_amount = 1
	forbidden_reagents = list()
	mix_sound = null

/datum/reagent/sonic_powder
	name = "Sonic Powder"
	id = "sonic_powder"
	description = "Makes a deafening noise."
	reagent_state = LIQUID
	color = "#0000FF"

/datum/chemical_reaction/sonic_powder
	name = "sonic_powder"
	id = "sonic_powder"
	result = "sonic_powder"
	required_reagents = list("oxygen" = 1, "cola" = 1, "phosphorus" = 1)
	result_amount = 3


/datum/chemical_reaction/sonic_powder_deafen
	name = "sonic_powder_deafen"
	id = "sonic_powder_deafen"
	result = null
	required_reagents = list("sonic_powder" = 1)
	min_temp = 374

/datum/reagent/phlogiston
	name = "Phlogiston"
	id = "phlogiston"
	description = "Catches you on fire and makes you ignite."
	reagent_state = LIQUID
	color = "#FF9999"


/datum/chemical_reaction/phlogiston
	name = "phlogiston"
	id = "phlogiston"
	result = "phlogiston"
	required_reagents = list("phosphorus" = 1, "sacid" = 1, "plasma" = 1)
	result_amount = 3

/datum/chemical_reaction/phlogiston/on_reaction(var/datum/reagents/holder, var/created_volume)
	if(holder.has_reagent("stabilizing_agent"))
		return
	var/turf/simulated/T = get_turf(holder.my_atom)
	for(var/turf/simulated/turf in range(created_volume/10,T))
	return

/datum/reagent/phlogiston/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.adjust_fire_stacks(1)
	M.IgniteMob()
	M.adjustFireLoss(0.2*M.fire_stacks)
	..()
	return

/datum/reagent/napalm
	name = "Napalm"
	id = "napalm"
	description = "Very flammable."
	reagent_state = LIQUID
	color = "#FF9999"


/datum/reagent/napalm/on_mob_life(var/mob/living/M as mob)
	if(!M) M = holder.my_atom
	M.adjust_fire_stacks(1)
	..()
	return

/datum/reagent/napalm/reaction_mob(var/mob/living/M, var/method=TOUCH, var/volume)
	if(method == TOUCH && isliving(M))
		M.adjust_fire_stacks(7)
		return

/datum/chemical_reaction/napalm
	name = "Napalm"
	id = "napalm"
	result = "napalm"
	required_reagents = list("sugar" = 1, "fuel" = 1, "ethanol" = 1 )
	result_amount = 1

datum/reagent/cryostylane
	name = "Cryostylane"
	id = "cryostylane"
	description = "Comes into existence at 20K. As long as there is sufficient oxygen for it to react with, Cryostylane slowly cools all other reagents in the mob down to 0K."
	color = "#B2B2FF" // rgb: 139, 166, 233


/datum/chemical_reaction/cryostylane
	name = "cryostylane"
	id = "cryostylane"
	result = "cryostylane"
	required_reagents = list("water" = 1, "plasma" = 1, "nitrogen" = 1)
	result_amount = 3

datum/reagent/cryostylane/on_mob_life(var/mob/living/M as mob) //TODO: code freezing into an ice cube
	if(M.reagents.has_reagent("oxygen"))
		M.reagents.remove_reagent("oxygen", 1)
		M.bodytemperature -= 30
	..()
	return

datum/reagent/cryostylane/on_tick()
	if(holder.has_reagent("oxygen"))
		holder.remove_reagent("oxygen", 1)
		holder.chem_temp -= 10
		holder.handle_reactions()
	..()
	return

datum/reagent/cryostylane/reaction_turf(var/turf/simulated/T, var/volume)
	if(volume >= 5)
		for(var/mob/living/carbon/slime/M in T)
			M.adjustToxLoss(rand(15,30))

datum/reagent/pyrosium
	name = "Pyrosium"
	id = "pyrosium"
	description = "Comes into existence at 20K. As long as there is sufficient oxygen for it to react with, Pyrosium slowly cools all other reagents in the mob down to 0K."
	color = "#B20000" // rgb: 139, 166, 233


/datum/chemical_reaction/pyrosium
	name = "pyrosium"
	id = "pyrosium"
	result = "pyrosium"
	required_reagents = list("plasma" = 1, "radium" = 1, "phosphorus" = 1)
	result_amount = 3

datum/reagent/pyrosium/on_mob_life(var/mob/living/M as mob)
	if(M.reagents.has_reagent("oxygen"))
		M.reagents.remove_reagent("oxygen", 1)
		M.bodytemperature += 30
	..()
	return

datum/reagent/pyrosium/on_tick()
	if(holder.has_reagent("oxygen"))
		holder.remove_reagent("oxygen", 1)
		holder.chem_temp += 10
		holder.handle_reactions()
	..()
	return

/datum/chemical_reaction/azide
	name = "azide"
	id = "azide"
	result = null
	required_reagents = list("chlorine" = 1, "oxygen" = 1, "nitrogen" = 1, "ammonia" = 1, "sodium" = 1, "silver" = 1)
	result_amount = 1
	mix_message = "The substance violently detonates!"

/datum/chemical_reaction/azide/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)
	explosion(location,0,1,3)
	return

datum/reagent/firefighting_foam
	name = "Firefighting foam"
	id = "firefighting_foam"
	description = "Carbon Tetrachloride is a foam used for fire suppression."
	reagent_state = LIQUID
	color = "#A0A090"
	var/cooling_temperature = 3 // more effective than water

/datum/chemical_reaction/firefighting_foam
	name = "firefighting_foam"
	id = "firefighting_foam"
	result = "firefighting_foam"
	required_reagents = list("carbon" = 1, "chlorine" = 1, "sulfur" = 1)
	result_amount = 3
	mix_message = "The mixture bubbles gently."

datum/reagent/firefighting_foam/reaction_mob(var/mob/living/M, var/method=TOUCH, var/volume)
	if(!istype(M, /mob/living))
		return

// Put out fire
	if(method == TOUCH)
		M.adjust_fire_stacks(-(volume / 5)) // more effective than water
		if(M.fire_stacks <= 0)
			M.ExtinguishMob()
		return

/datum/chemical_reaction/clf3_firefighting
	name = "clf3_firefighting"
	id = "clf3_firefighting"
	result = null
	required_reagents = list("firefighting_foam" = 1, "clf3" = 1)
	result_amount = 1
	mix_message = "The substance violently detonates!"

/datum/chemical_reaction/clf3_firefighting/on_reaction(var/datum/reagents/holder, var/created_volume)
	var/location = get_turf(holder.my_atom)
	explosion(location,0,0,3)
	return

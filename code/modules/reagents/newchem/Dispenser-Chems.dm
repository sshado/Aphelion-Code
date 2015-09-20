#define SOLID 1
#define LIQUID 2
#define GAS 3

#define REM REAGENTS_EFFECT_MULTIPLIER

//////////////////////////////////////
//Your Basic Chemicals//
/////////////////////////////////////

/datum/reagent/aluminum
	name = "Aluminum"
	id = "aluminum"
	description = "A silvery white and ductile member of the boron group of chemical elements."
	reagent_state = SOLID
	color = "#A8A8A8"

/datum/reagent/carbon
	carbon
	name = "Carbon"
	id = "carbon"
	description = "A chemical element."
	reagent_state = SOLID
	color = "#1C1300" // rgb: 30, 20, 0

	reaction_turf(var/turf/T, var/volume)
		src = null
	// Only add one dirt per turf.  Was causing people to crash.
		if(!istype(T, /turf/space) && !(locate(/obj/effect/decal/cleanable/dirt) in T))
			new /obj/effect/decal/cleanable/dirt(T)

/datum/reagent/chlorine
	name = "Chlorine"
	id = "chlorine"
	description = "A chemical element."
	reagent_state = GAS
	color = "#808080" // rgb: 128, 128, 128


	on_mob_life(var/mob/living/M as mob)
		if(!M) M = holder.my_atom
		M.adjustFireLoss(1)
		..()
		return

/datum/reagent/copper
	name = "Copper"
	id = "copper"
	description = "A highly ductile metal."
	color = "#6E3B08" // rgb: 110, 59, 8

/datum/reagent/ethanol
	name = "Ethanol" //Parent class for all alcoholic reagents.
	id = "ethanol"
	description = "A well-known alcohol with a variety of applications."
	reagent_state = LIQUID
	nutriment_factor = 0 //So alcohol can fill you up! If they want to.
	color = "#404030" // rgb: 64, 64, 48
	var/dizzy_adj = 3

	on_mob_life(var/mob/living/M as mob, var/alien)
		// Sobering multiplier.
		// Sober block makes it more difficult to get drunk
		var/sober_str=!(SOBER in M.mutations)?1:2
		M:nutrition += nutriment_factor
		holder.remove_reagent(src.id, FOOD_METABOLISM)
		if(!src.data) data = 1
		src.data++

		var/d = data

		// make all the beverages work together
		for(var/datum/reagent/ethanol/A in holder.reagent_list)
			if(isnum(A.data)) d += A.data

		d/=sober_str

		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(H.species && (H.species.name == "Skrell" || H.species.name =="Neara"))	 //Skrell and Neara get very drunk very quickly.
				d*=5

		M.dizziness += dizzy_adj.
		if(d >= slur_start && d < pass_out)
			if (!M:slurring) M:slurring = 1
			M:slurring += slurr_adj/sober_str
		if(d >= confused_start && prob(33))
			if (!M:confused) M:confused = 1
			M.confused = max(M:confused+(confused_adj/sober_str),0)
		if(d >= blur_start)
			M.eye_blurry = max(M.eye_blurry, 10/sober_str)
			M:drowsyness  = max(M:drowsyness, 0)
		if(d >= vomit_start)
			if(prob(8))
				M.fakevomit()
		if(d >= pass_out)
			M:paralysis = max(M:paralysis, 20/sober_str)
			M:drowsyness  = max(M:drowsyness, 30/sober_str)
			if(ishuman(M))
				var/mob/living/carbon/human/H = M
				var/obj/item/organ/liver/L = H.internal_organs_by_name["liver"]
				if (istype(L))
					L.take_damage(0.1, 1)
				H.adjustToxLoss(0.1)
		holder.remove_reagent(src.id, 0.4)
		..()
		return

	reaction_obj(var/obj/O, var/volume)
		if(istype(O,/obj/item/weapon/paper))
			var/obj/item/weapon/paper/paperaffected = O
			paperaffected.clearpaper()
			usr << "The solution melts away the ink on the paper."
		if(istype(O,/obj/item/weapon/book))
			if(volume >= 5)
				var/obj/item/weapon/book/affectedbook = O
				affectedbook.dat = null
				usr << "The solution melts away the ink on the book."
			else
				usr << "It wasn't enough..."
		return

	affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
		if(!istype(M, /mob/living))
			M.adjust_fire_stacks(volume / 15)
			return

/datum/reagent/fluorine
	name = "Fluorine"
	id = "fluorine"
	description = "A highly-reactive chemical element."
	reagent_state = GAS
	color = "#6A6054"



	on_mob_life(var/mob/living/M as mob)
		if(!M) M = holder.my_atom
		M.adjustFireLoss(1)
		M.adjustToxLoss(1*REM)
		..()

/datum/reagent/hydrogen
	name = "Hydrogen"
	id = "hydrogen"
	description = "A colorless, odorless, nonmetallic, tasteless, highly combustible diatomic gas."
	reagent_state = GAS
	color = "#808080" // rgb: 128, 128, 128

/datum/reagent/iron
	name = "Iron"
	id = "iron"
	description = "Pure iron is a metal."
	reagent_state = SOLID
	color = "#C8A5DC" // rgb: 200, 165, 220
/*
			on_mob_life(var/mob/living/M as mob)
				if(!M) M = holder.my_atom
				if((M.virus) && (prob(8) && (M.virus.name=="Magnitis")))
					if(M.virus.spread == "Airborne")
						M.virus.spread = "Remissive"
					M.virus.stage--
					if(M.virus.stage <= 0)
						M.resistances += M.virus.type
						M.virus = null
				holder.remove_reagent(src.id, 0.2)
				return
*/

/datum/reagent/lithium
	name = "Lithium"
	id = "lithium"
	description = "A chemical element."
	reagent_state = SOLID
	color = "#808080" // rgb: 128, 128, 128

	on_mob_life(var/mob/living/M as mob)
		if(!M) M = holder.my_atom
		if(M.canmove && !M.restrained() && istype(M.loc, /turf/space))
			step(M, pick(cardinal))
		if(prob(5)) M.emote(pick("twitch","drool","moan"))
		..()
		return
/datum/reagent/mercury
	name = "Mercury"
	id = "mercury"
	description = "A chemical element."
	reagent_state = LIQUID
	color = "#484848" // rgb: 72, 72, 72
	metabolization_rate = 0.2


	on_mob_life(var/mob/living/M as mob)
		if(!M) M = holder.my_atom
		if(prob(70))
			M.adjustBrainLoss(1)
		..()
		return

/datum/reagent/nitrogen
	name = "Nitrogen"
	id = "nitrogen"
	description = "A colorless, odorless, tasteless gas."
	reagent_state = GAS
	color = "#808080" // rgb: 128, 128, 128


	on_mob_life(var/mob/living/M as mob, var/alien)
		if(M.stat == 2) return
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(H.species && (H.species.name == "Vox" || H.species.name =="Vox Armalis"))
				M.adjustOxyLoss(-2*REM)
				holder.remove_reagent(src.id, REAGENTS_METABOLISM) //By default it slowly disappears.
				return
		..()

/datum/reagent/oxygen
	name = "Oxygen"
	id = "oxygen"
	description = "A colorless, odorless gas."
	reagent_state = GAS
	color = "#808080" // rgb: 128, 128, 128

	on_mob_life(var/mob/living/M as mob, var/alien)
		if(M.stat == 2) return
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(H.species && (H.species.name == "Vox" || H.species.name =="Vox Armalis"))
				M.adjustToxLoss(REAGENTS_METABOLISM)
				holder.remove_reagent(src.id, REAGENTS_METABOLISM) //By default it slowly disappears.
				return
		..()

/datum/reagent/phosphorus
			name = "Phosphorus"
			id = "phosphorus"
			description = "A chemical element."
			reagent_state = SOLID
			color = "#832828" // rgb: 131, 40, 40

/datum/reagent/potassium
	name = "Potassium"
	id = "potassium"
	description = "A soft, low-melting solid that can easily be cut with a knife. Reacts violently with water."
	reagent_state = SOLID
	color = "#A0A0A0" // rgb: 160, 160, 160

/datum/reagent/radium
	name = "Radium"
	id = "radium"
	description = "Radium is an alkaline earth metal. It is extremely radioactive."
	reagent_state = SOLID
	color = "#C7C7C7" // rgb: 199,199,199
	metabolization_rate = 0.4


	on_mob_life(var/mob/living/M as mob)
		if(!M) M = holder.my_atom
		M.apply_effect(4*REM,IRRADIATE,0)
		// radium may increase your chances to cure a disease
		if(istype(M,/mob/living/carbon)) // make sure to only use it on carbon mobs
			var/mob/living/carbon/C = M
			if(C.virus2.len)
				for (var/ID in C.virus2)
					var/datum/disease2/disease/V = C.virus2[ID]
					if(prob(5))
						if(prob(50))
							M.apply_effect(50,IRRADIATE,0) // curing it that way may kill you instead
							M.adjustToxLoss(100)
						C.antibodies |= V.antigen
		..()
		return

	reaction_turf(var/turf/T, var/volume)
		src = null
		if(volume >= 3)
			if(!istype(T, /turf/space))
				new /obj/effect/decal/cleanable/greenglow(T)
				return

/datum/reagent/sacid
	name = "Sulphuric acid"
	id = "sacid"
	description = "A strong mineral acid with the molecular formula H2SO4."
	reagent_state = LIQUID
	color = "#00D72B"

	on_mob_life(var/mob/living/M as mob)
		if(!M) M = holder.my_atom
		M.adjustFireLoss(1)
		..()
		return
	affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
		if(!istype(M, /mob/living))
			return
		if(ishuman(M))
			var/mob/living/carbon/human/H = M

			if(volume > 25)

				if(H.wear_mask)
					H << "\red Your mask protects you from the acid!"
					return

				if(H.head)
					H << "\red Your helmet protects you from the acid!"
					return

				if(!M.unacidable)
					if(prob(75))
						var/obj/item/organ/external/affecting = H.get_organ("head")
						if(affecting)
							affecting.take_damage(20, 0)
							H.UpdateDamageIcon()
							H.emote("scream")
					else
						M.take_organ_damage(15,0)
			else
				M.take_organ_damage(15,0)

/datum/reagent/silicon
	name = "Silicon"
	id = "silicon"
	description = "A tetravalent metalloid, silicon is less reactive than its chemical analog carbon."
	reagent_state = SOLID
	color = "#A8A8A8" // rgb: 168, 168, 168

/datum/reagent/sodiumchloride
	name = "Salt"
	id = "sodiumchloride"
	description = "Sodium chloride, common table salt."
	reagent_state = SOLID
	color = "#B1B0B0"

	overdose_process(var/mob/living/M as mob)
		if(volume > 100)
			if(prob(70))
				M.adjustBrainLoss(1)
			if(prob(8))
				M.adjustToxLoss(rand(1,2))
		..()
		return

/datum/reagent/sugar
	name = "Sugar"
	id = "sugar"
	description = "The organic compound commonly known as table sugar and sometimes called saccharose. This white, odorless, crystalline powder has a pleasing, sweet taste."
	reagent_state = SOLID
	color = "#FFFFFF" // rgb: 255, 255, 255
	overdose_threshold = 200 // Hyperglycaemic shock

	on_mob_life(var/mob/living/M as mob)
		if(prob(4))
			M.reagents.add_reagent("epinephrine", 1.2)
		if(prob(50))
			M.AdjustParalysis(-1)
			M.AdjustStunned(-1)
			M.AdjustWeakened(-1)
		if(current_cycle >= 90)
			M.jitteriness += 10
		..()
		return

	overdose_process(var/mob/living/M as mob)
		if(volume > 200)
			M << "<span class = 'danger'>You pass out from hyperglycemic shock!</span>"
			M.Paralyse(1)
			if(prob(8))
				M.adjustToxLoss(rand(1,2))
		..()
		return

/datum/reagent/sulfur
	name = "Sulfur"
	id = "sulfur"
	description = "A chemical element."
	reagent_state = SOLID
	color = "#BF8C00" // rgb: 191, 140, 0

/datum/reagent/tungsten
	name = "Tungsten"
	id = "tungsten"
	description = "A chemical element, and a strong oxidising agent."
	reagent_state = SOLID
	color = "#DCDCDC"

#define WATER_LATENT_HEAT 19000 // How much heat is removed when applied to a hot turf, in J/unit (19000 makes 120 u of water roughly equivalent to 4L)
/datum/reagent/water
	name = "Water"
	id = "water"
	description = "A ubiquitous chemical substance that is composed of hydrogen and oxygen."
	reagent_state = LIQUID
	color = "#0064C877"
	metabolization_rate = REAGENTS_METABOLISM * 10
datum/reagent/water/proc/affect_touch_turf_w(var/turf/simulated/T)
	if(!istype(T))
		return
	var/datum/gas_mixture/environment = T.return_air()
	var/min_temperature = T0C + 100 // 100C, the boiling point of water
	var/hotspot = (locate(/obj/fire) in T)
	if(hotspot && !istype(T, /turf/space))
		var/datum/gas_mixture/lowertemp = T.remove_air(T:air:total_moles)
		lowertemp.temperature = max(min(lowertemp.temperature-2000, lowertemp.temperature / 2), 0)
		lowertemp.react()
		T.assume_air(lowertemp)
		qdel(hotspot)
	if (environment && environment.temperature > min_temperature) // Abstracted as steam or something
		var/removed_heat = between(0, volume * WATER_LATENT_HEAT, -environment.get_thermal_energy_change(min_temperature))
		environment.add_thermal_energy(-removed_heat)
		if (prob(5))
			T.visible_message("<span class='warning'>The water sizzles as it lands on \the [T]!</span>")
	else if(volume >= 10)
		if(T.wet >= 1)
			return
		T.wet = 1
		if(T.wet_overlay)
			T.overlays -= T.wet_overlay
			T.wet_overlay = null
		T.wet_overlay = image('icons/effects/water.dmi',T,"wet_floor")
		T.overlays += T.wet_overlay
		spawn(800) // This is terrible and needs to be changed when possible.
			if(!T || !istype(T))
				return
			if(T.wet >= 2)
				return
			T.wet = 0
			if(T.wet_overlay)
				T.overlays -= T.wet_overlay
				T.wet_overlay = null

/datum/reagent/xenon
	name = "Xenon"
	id = "xenon"
	description = "Xenon is a relatively stable gas that emits a lavenderish glow."
	reagent_state = GAS
	color = "#6A6054"

	on_mob_life(var/mob/living/M as mob)
		if(!M) M = holder.my_atom
		M.drowsyness = max(M.drowsyness, 2.5)
		..()
		return

/datum/reagent/zinc
	name = "Zinc"
	id = "zinc"
	description = "Zinc is a antioxidant metal that could possibility acclerate healing."
	color = "#6E3B08" // rgb: 110, 59, 8
	overdose_threshold = 120 // Zinc Poisioning
	on_mob_life(var/mob/living/M as mob)
		if(prob(11))
			M.adjustToxLoss(-1)
		..()
		return

	overdose_process(var/mob/living/M as mob)
		if(volume > 120)
			if(prob(50))
				M.adjustToxLoss(rand(1,2))
		..()
		return


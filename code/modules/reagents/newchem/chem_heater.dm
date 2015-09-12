/obj/machinery/chem_heater
	name = "chemical heater"
	density = 1
	anchored = 1
	icon = 'icons/obj/chemical.dmi'
	icon_state = "mixer0b"
	use_power = 1
	idle_power_usage = 65
	var/obj/item/weapon/reagent_containers/beaker = null
	var/desired_temp = 420 // 296.33 Degrees Fahrenheit
	var/heater_coefficient = 0.04
	var/on = FALSE

/obj/machinery/chem_heater/New()
	var/datum/reagents/R = new/datum/reagents(100)
	reagents = R
	R.my_atom = src
	..()
	component_parts = list()
//	component_parts += new /obj/item/weapon/circuitboard/chem_heater(null)
	component_parts += new /obj/item/weapon/stock_parts/micro_laser(null)
	component_parts += new /obj/item/weapon/stock_parts/console_screen(null)
	RefreshParts()

/obj/machinery/chem_heater/upgraded/New()
	..()
	component_parts = list()
//	component_parts += new /obj/item/weapon/circuitboard/chem_heater(null)
	component_parts += new /obj/item/weapon/stock_parts/micro_laser/ultra(null)
	component_parts += new /obj/item/weapon/stock_parts/console_screen(null)
	RefreshParts()

/obj/machinery/chem_heater/RefreshParts()
	heater_coefficient = 0.03
	for(var/obj/item/weapon/stock_parts/micro_laser/M in component_parts)
		heater_coefficient *= M.rating

/obj/machinery/chem_heater/process()
	..()
	if(stat & NOPOWER)
		return
	var/state_change = 0
	if(on)
		if(beaker)
			if(beaker.reagents.chem_temp > desired_temp)
				beaker.reagents.chem_temp += min(-1, max((desired_temp - beaker.reagents.chem_temp) * heater_coefficient, -15))
			if(beaker.reagents.chem_temp < desired_temp)
				beaker.reagents.chem_temp += max(1, min((desired_temp - beaker.reagents.chem_temp) * heater_coefficient, 15))
			beaker.reagents.chem_temp = round(beaker.reagents.chem_temp) //stops stuff like 456.12312312302

			beaker.reagents.handle_reactions()
			state_change = 1

	if(state_change)
		nanomanager.update_uis(src)

/obj/machinery/chem_heater/proc/eject_beaker()
	if(beaker)
		beaker.loc = get_turf(src)
		beaker.reagents.handle_reactions()
		beaker = null
		icon_state = "mixer0b"
		on = FALSE
		nanomanager.update_uis(src)

/obj/machinery/chem_heater/power_change()
	if(powered())
		stat &= ~NOPOWER
	else
		spawn(rand(0, 15))
			stat |= NOPOWER
	nanomanager.update_uis(src)

/obj/machinery/chem_heater/attackby(var/obj/item/weapon/B as obj, var/mob/user as mob, params)

	if(istype(B, /obj/item/weapon/reagent_containers/glass) || istype(B, /obj/item/weapon/reagent_containers/food/drinks/drinkingglass))

		if(src.beaker)
			user << "A beaker is already loaded into the machine."
			return
		src.beaker = B
		user.drop_item()
		B.loc = src
		user << "You add the beaker to the machine!"
		src.updateUsrDialog()
		nanomanager.update_uis(src) // update all UIs attached to src
		icon_state = "mixer0b"

		nanomanager.update_uis(src) // update all UIs attached to src
		return

	if(default_deconstruction_screwdriver(user, "mixer0b", "mixer0b", B))
		return



///	if(exchange_parts(user, I))
///		return

	if(panel_open)
		if(istype(B, /obj/item/weapon/crowbar))
			eject_beaker()
			default_deconstruction_crowbar(B)
			return 1

/obj/machinery/chem_heater/attack_hand(var/mob/user as mob)
	ui_interact(user)

/obj/machinery/chem_heater/attack_ai(mob/user as mob)
	src.add_hiddenprint(user)
	return src.attack_hand(user)

/obj/machinery/chem_heater/Topic(href, href_list)
	if(..())
		return 0

	if(href_list["toggle_on"])
		on = !on
		. = 1

	if(href_list["adjust_temperature"])
		var/val = href_list["adjust_temperature"]
		if(isnum(val))
			desired_temp = Clamp(desired_temp+val, 0, 1500)
		else if(val == "input")
			var/target = input("Please input the target temperature", name) as num
			desired_temp = Clamp(target, 0, 1500)
		else
			return 0
		. = 1

	if(href_list["eject_beaker"])
		eject_beaker()
		. = 0 //updated in eject_beaker() already



/obj/machinery/chem_heater/ui_interact(var/mob/user, ui_key = "main", var/datum/nanoui/ui = null)
	if(user.stat || user.restrained()) return

	var/data[0]
	data["targetTemp"] = desired_temp
	data["isActive"] = on
	data["isBeakerLoaded"] = beaker ? 1 : 0

	data["currentTemp"] = beaker ? beaker.reagents.chem_temp : null
	data["beakerCurrentVolume"] = beaker ? beaker.reagents.total_volume : null
	data["beakerMaxVolume"] = beaker ? beaker.volume : null

	//copy-pasted from chem dispenser
	var beakerContents[0]
	if(beaker)
		for(var/datum/reagent/R in beaker.reagents.reagent_list)
			beakerContents.Add(list(list("name" = R.name, "volume" = R.volume))) // list in a list because Byond merges the first list...
	data["beakerContents"] = beakerContents

	// update the ui if it exists, returns null if no ui is passed/found
	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data)
	if (!ui)
		// the ui does not exist, so we'll create a new() one
        // for a list of parameters and their descriptions see the code docs in \code\modules\nano\nanoui.dm
		ui = new(user, src, ui_key, "chem_heater.tmpl", 390, 655)
		// when the ui is first opened this is the data it will use
		ui.set_initial_data(data)
		// open the new ui window
		ui.open()
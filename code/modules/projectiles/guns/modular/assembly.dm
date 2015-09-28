//Frames are the starting blocks of the weapon. The type of frame decides how large a weapon you can build.
//In general, weight affects the size and weight (slow to use, bulky, etc) of the weapon

/datum/firemode/modular
	name = "modular-default"
	burst = 1
	burst_delay = null
	fire_delay = null
	move_delay = 1
	list/accuracy = list(0)
	list/dispersion = list(0)

obj/item/weapon/modular_firearms/assembly
	name = "standard assembly"
	desc = "The outer framework for a firearm of some kind. This one looks rather basic."
	icon = 'icons/placeholder.dmi'
	var/mastertype = null
	var/compiled = null
	var/msg = null
	var/modChassis = null
	var/modChamber = null
	var/modDriver = null
	var/modLoader = null
	var/modBarrel = null
	var/modStock = null
	var/modSight = null
	var/modMisc = list()
	w_class = 3
	var/isEnergy = null
	var/isKinetic = null
	var/list/components = list()
	var/list/removable = list()
	var/useCell = null
	var/useSupply = null
	var/useBullet = null

/obj/item/weapon/modular_firearms/assembly/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/weapon/modular_firearms))
		var/part = null
		var/prereq = null
		if(istype(I, /obj/item/weapon/modular_firearms/chassis))
			part = modChassis
			prereq = null
	
		else if(istype(I, /obj/item/weapon/modular_firearms/chamber))
			part = modChamber
			prereq = modChassis
	
		else if(istype(I, /obj/item/weapon/modular_firearms/driver))
			part = modDriver
			prereq = modChamber
	
		else if(istype(I, /obj/item/weapon/modular_firearms/loader))
			part = modLoader
			prereq = modChamber

		else if(istype(I, /obj/item/weapon/modular_firearms/barrel))
			part = modBarrel
			prereq = modChamber

		else if(istype(I, /obj/item/weapon/modular_firearms/stock))
			part = modStock
			prereq = modChassis
			
		else if(istype(I, /obj/item/weapon/modular_firearms/sight))
			part = modSight
			prereq = modChassis
		
		add_part(I, user, part, prereq)

obj/item/weapon/modular_firearms/assembly/heavy
	name = "heavy assembly"
	desc = "The outer framework for a firearm. You could probably make something over the top with this."
	w_class = 4

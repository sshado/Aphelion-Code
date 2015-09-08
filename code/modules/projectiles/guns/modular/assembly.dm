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
	name = "basic assembly"
	desc = "The outer framework for a firearm of some kind. This one looks rather basic."
	icon = 'icons/placeholder.dmi'
	var/msg = null
	var/modChassis = null
	var/modChamber = null
	var/modDriver = null
	var/modLoader = null
	var/modBarrel = null
	var/modStock = null
	var/modSight = null
	var/modMisc = list()
	var/framelevel = 2
	var/weight = 1
	var/isEnergy = null
	var/isKinetic = null
	var/silenced = null
	var/compensated = null
	var/list/components = new/list()
	var/useCell = null
	var/useSupply = null
	var/useBullet = null

/obj/item/weapon/modular_firearms/assembly/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/weapon/modular_firearms/chassis))
		if(!modChassis)
			add_part(I, user)
		//	weight = I.weight + weight
		else

	if(istype(I, /obj/item/weapon/modular_firearms/chamber))
		var/part = modChamber
		var/prereq = modChassis
		if((!modChamber) && (modChassis))
			add_part(I, user)
		//	weight = I.weight + weight

	if(istype(I, /obj/item/weapon/modular_firearms/driver))
		var/part = modDriver
		var/prereq = modChamber
		if((!modDriver) && (modChamber))
			add_part(I, user)

	if(istype(I, /obj/item/weapon/modular_firearms/loader))
		var/part = modLoader
		var/prereq = modChamber
		if((!modLoader) && (modChamber))
			add_part(I, user)

	if(istype(I, /obj/item/weapon/modular_firearms/barrel))
		var/part = modBarrel
		var/prereq = modChamber
		if((!modBarrel) && (modChamber))
			add_part(I, user)

	if(istype(I, /obj/item/weapon/modular_firearms/stock))
		var/part = modStock
		var/prereq = modChassis
		if((!modStock) && (modChassis))
			add_part(I, user)
			
	if(istype(I, /obj/item/weapon/modular_firearms/sight))
		var/part = modSight
		var/prereq = modChassis
		if((!modSight) && (modChassis))
			add_part(I, user)




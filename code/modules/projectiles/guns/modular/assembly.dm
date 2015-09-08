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
		if((!modChamber) && (modChassis))
			add_part(I, user)
		//	weight = I.weight + weight
		else if(modChamber)
			user << "\red There is already a [modChamber] installed!"
		else if(!modChamber)
			user << "\red The [I] needs to be attached to a chassis!"

	if(istype(I, /obj/item/weapon/modular_firearms/driver))
		if((!modDriver) && (modChamber))
			add_part(I, user)
		else if(modDriver)
			user << "\red There is already a [modDriver] installed!"
		else if(!modChamber)
			user << "\red The [I] needs to be attached to a chamber!"

	if(istype(I, /obj/item/weapon/modular_firearms/loader))
		if((!modLoader) && (modChamber))
			add_part(I, user)
		else if(modLoader)
			user << "\red There is already a [modLoader] installed!"
		else if(!modChamber)
			user << "\red The [I] needs to be attached to a chamber!"

	if(istype(I, /obj/item/weapon/modular_firearms/barrel))
		if((!modBarrel) && (modChamber))
			add_part(I, user)
		else if(modBarrel)
			user << "\red There is already a [modBarrel] installed!"
		else if(!modChamber)
			user << "\red The [I] needs to be attached to a chamber!"
			

	if(istype(I, /obj/item/weapon/modular_firearms/stock))
		if((!modStock) && (modChassis))
			add_part(I, user)
		else if(modStock)
			user << "\red There is already a [modStock] installed!"
		else if(!modChassis)
			user << "\red The [I] needs to be attached to a chassis!"
			
	if(istype(I, /obj/item/weapon/modular_firearms/sight))
		if((!modSight) && (modChassis))
			add_part(I, user)
		else if(modSight)
			user << "\red There is already a [modSight] installed!"
		else if(!modChassis)
			user << "\red The [I] needs to be attached to a chassis!"




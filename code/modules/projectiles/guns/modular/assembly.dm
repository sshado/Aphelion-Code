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
	var/modChassis = null
	var/modChamber = null
	var/modDriver = null
	var/modLoader = null
	var/modBarrel = null
	var/modStock = null
	var/modLock = null
	var/firemode = /datum/firemode/modular
	var/modSight = null
	var/modMisc = list()
	var/projectile_type = null
	var/framelevel = 2
	var/chargecost = null
	var/weight = 1
	var/isEnergy = null
	var/isKinetic = null
	var/caliber
	var/silenced = null
	var/accuracy_mod = null
	var/compensated = null
	var/haspin = 0
	var/buildstage = 1
	var/list/components = new/list()
	var/burst = 1
	var/burst_delay = null
	var/fire_delay = null
	var/move_delay = 1
	var/list/accuracy = list(0)
	var/list/dispersion = list(0)

/obj/item/weapon/modular_firearms/assembly/attackby(obj/item/I as obj, mob/user as mob)
	if(buildstage == 1)
		if(istype(I, /obj/item/weapon/modular_firearms/chassis))
			user.drop_item()
			I.loc = src
			components += I
			modChassis = I
			if(istype(I, /obj/item/weapon/modular_firearms/chassis/energy))
				isEnergy = 1
			if(istype(I, /obj/item/weapon/modular_firearms/chassis/ballistic))
				isKinetic = 1
			user << "\blue You install the [I] onto the [src]. Now you should install a chamber."
		//	weight = I.weight + weight
			buildstage += 1
		else
			user << "\red You must install a chassis first!"

	else if(buildstage == 2)
		if(istype(I, /obj/item/weapon/modular_firearms/chamber))
			user.drop_item()
			I.loc = src
			components += I
			modChamber = I
			var/obj/item/weapon/modular_firearms/chamber/chamber = I
			if(chamber.projectile_type)
				if(isEnergy)
					projectile_type = chamber.projectile_type
				else
					user << "\red A ballistic chamber won't work with an energy chassis!"
			if(chamber.caliber)
				if(isKinetic)
					caliber = chamber.caliber
				else
					user << "\red An energy chamber won't work with a ballistic chassis!"
			user << "\blue You install the [I] onto the [src]. Now you should install the driver."
		//	weight = I.weight + weight
			buildstage += 1
		else
			user << "\red You must install a chamber first!"

	else if(buildstage == 3)
		if(istype(I, /obj/item/weapon/modular_firearms/driver))
			user.drop_item()
			I.loc = src
			components += I
			modDriver = I
			var/obj/item/weapon/modular_firearms/driver/D = I
			if(D.burst)
				burst = D.burst
				burst_delay = D.burst_delay
				fire_delay = D.fire_delay
				move_delay = D.move_delay
				accuracy = D.accuracy
				dispersion = D.dispersion
			else
				user << "\red How did you manage this?"
			user << "\blue You install the [I] into the [src]."
			buildstage += 1
		else
			user << "\red You must install a driver first!"
	else if(buildstage == 4)
		if(istype(I, /obj/item/weapon/modular_firearms/loader))
			user.drop_item()
			I.loc = src
			components += I
			buildstage += 1

	else if(buildstage == 5)
		if(istype(I, /obj/item/weapon/modular_firearms/barrel))
			user.drop_item()
			I.loc = src
			components += I
			buildstage += 1

	else if(buildstage == 6)
		if(istype(I, /obj/item/weapon/modular_firearms/stock))
			user.drop_item()
			I.loc = src
			components += I
			buildstage += 1

	else if(buildstage == 7)
		if(istype(I, /obj/item/weapon/modular_firearms/lockpin))
			user.drop_item()
			I.loc = src
			components += I
			buildstage += 1

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
	
/obj/item/weapon/modular_firearms/assembly/process_part(obj/item/I as obj, mob/user as mob) //this should handle processing new parts in the weapon, without relying on the weapon actually being attacked.
	if(istype(I, /obj/item/weapon/modular_firearms/chassis)) 
		if(istype(I, /obj/item/weapon/modular_firearms/chassis/energy))
			isEnergy = 1
		if(istype(I, /obj/item/weapon/modular_firearms/chassis/ballistic))
			isKinetic = 1
		modChassis = I
	if(istype(I, /obj/item/weapon/modular_firearms/chamber))
		var/obj/item/weapon/modular_firearms/chamber/chamber = I
		if(chamber.projectile_type) //checking for energy weaponry
			if(isEnergy)
			else
				user << "\red A ballistic chamber won't work with an energy chassis!"
				return
		if(chamber.caliber) //checking for kinetic weaponry
			if(isKinetic)
			else
				user << "\red An energy chamber won't work with a ballistic chassis!"
				return
		modChamber = I
	if(istype(I, /obj/item/weapon/modular_firearms/driver))
		var/obj/item/weapon/modular_firearms/driver/D = I
		if(D.firemodes)
		else
			user << "\red How did you manage this?"
			return
		modDriver = I
	if(istype(I, /obj/item/weapon/modular_firearms/loader))
		var/obj/item/weapon/modular_firearms/loader/L = I
		if(!L.Eloader)
			useBullet = 1
		if(L.Eloader)
			if(L.useCell)
				useCell = 1
			if(L.useSupply)
				useSupply = 1
		modLoader = I
	if(istype(I, /obj/item/weapon/modular_firearms/barrel))
		modBarrel += I
	if(istype(I, /obj/item/weapon/modular_firearms/stock))
		modStock += I
	if(istype(I, /obj/item/weapon/modular_firearms/scope))
		modScope += I
	
/obj/item/weapon/modular_firearms/assembly/add_part(obj/item/I as obj, mob/user as mob) //Handles all part processing in a single proc. So clean~
	user.drop_item()
	I.loc = src
	components += I
	process_part(I, user)

/obj/item/weapon/modular_firearms/assembly/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/weapon/modular_firearms/chassis))
		if(!modChassis)
			add_part(I, user)
			user << "\blue You install the [I] onto the [src]."
		//	weight = I.weight + weight
		else

	if(istype(I, /obj/item/weapon/modular_firearms/chamber))
		if((!modChamber) && (modChassis))
			add_part(I, user)
			user << "\blue You install the [I] onto the [src]."
		//	weight = I.weight + weight
		else if(modChamber)
			user << "\red There is already a [modChamber] installed!"
		else if(!modChamber)
			user << "\red The [I] needs to be attached to a chassis!"

	if(istype(I, /obj/item/weapon/modular_firearms/driver))
		if((!modDriver) && (modChamber))
			add_part(I, user)
			user << "\blue You install the [I] onto the [src]."
		else if(modDriver)
			user << "\red There is already a [modDriver] installed!"
		else if(!modChamber)
			user << "\red The [I] needs to be attached to a chamber!"

	if(istype(I, /obj/item/weapon/modular_firearms/loader))
		if((!modLoader) && (modChamber))
			add_part(I, user)
			user << "\blue You install the [I] onto the [src]."
		else if(modLoader)
			user << "\red There is already a [modLoader] installed!"
		else if(!modChamber)
			user << "\red The [I] needs to be attached to a chamber!"

	if(istype(I, /obj/item/weapon/modular_firearms/barrel))
		if((!modBarrel) && (modChamber))
			add_part(I, user)
			

	if(istype(I, /obj/item/weapon/modular_firearms/stock))
		if((!modStock) && (modChassis))
			add_part(I, user)
			
	if(istype(I, /obj/item/weapon/modular_firearms/scope))
		if((!modScope) && (modChassis))
			add_part(I, user)




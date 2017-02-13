//MFCS procs -- Cirra


/obj/item/weapon/modular_firearms/assembly/proc/process_part(obj/item/I as obj, mob/user as mob) //this should handle processing new parts in the weapon, without relying on the weapon actually being attacked.
	if(istype(I, /obj/item/weapon/modular_firearms/chassis))
		if(istype(I, /obj/item/weapon/modular_firearms/chassis/energy))
			src.isEnergy = 1
		if(istype(I, /obj/item/weapon/modular_firearms/chassis/ballistic))
			src.isKinetic = 1
		modChassis = I
		src.removable += I //adds itself to the removable list
	if(istype(I, /obj/item/weapon/modular_firearms/chamber))
		var/obj/item/weapon/modular_firearms/chamber/chamber = I
		if(chamber.projectile_type) //checking for energy weaponry
			if(src.isEnergy)
			else
				src.msg = "\red A ballistic chamber won't work with an energy chassis!"
				return
		if(chamber.caliber) //checking for kinetic weaponry
			if(src.isKinetic)
			else
				src.msg = "\red An energy chamber won't work with a ballistic chassis!"
				return
		src.modChamber = I
		src.removable -= src.modChassis //removes its source part from the removable list.
		src.removable += I
	if(istype(I, /obj/item/weapon/modular_firearms/driver))
		var/obj/item/weapon/modular_firearms/driver/D = I
		if(D.firemodes)
		else
			src.msg = "\red Have you considered using a real driver?" //this will usually only be returned if
			return							  // they try and use the base driver
		src.modDriver = I
		src.removable += I
		src.removable -= src.modChamber
	if(istype(I, /obj/item/weapon/modular_firearms/loader))
		var/obj/item/weapon/modular_firearms/loader/L = I
		if(!L.Eloader)
			useBullet = 1
		if(L.Eloader)
			if(L.useCell)
				useCell = 1
			if(L.useSupply)
				useSupply = 1
		src.modLoader = I
		src.removable += I
		src.removable -= src.modChamber
	if(istype(I, /obj/item/weapon/modular_firearms/barrel))
		var/obj/item/weapon/modular_firearms/barrel/B = I
		src.modBarrel = I
		src.removable += I
		src.removable -= src.modChamber
	if(istype(I, /obj/item/weapon/modular_firearms/stock))
		src.modStock += I
		src.removable += I
		src.removable -= src.modChassis
	if(istype(I, /obj/item/weapon/modular_firearms/sight))
		src.modSight += I
		src.removable += I
		src.removable -= src.modChassis
	
/obj/item/weapon/modular_firearms/assembly/proc/add_part(obj/item/I as obj, mob/user as mob, var/part, var/prereq) //Handles all part processing in a single proc. So clean~
	if(part)
		if(part in src.components)
			user << "\red There is already a [part] installed!"
			return
	else
		user << "\red Error - null part variable for [I]." //for debugging
		return
	if(prereq)
		if(!prereq in src.components)
			user << "\red The [I] needs to be attached to a [prereq]!"
			return
	src.process_part(I, user)
	if(!src.msg)
		src.msg = ("\blue You install the [I] onto the [src].")
	user << src.msg
	user.drop_item()
	I.loc = src
	src.components += I

/obj/item/weapon/modular_firearms/assembly/proc/remove_part(obj/item/I as obj, mob/user as mob)
	var/picked = input("Select part to remove", "none")as null|anything in removable
	if(!picked || !removable[picked])
		return
	var/removing = removable[picked]
	removing.loc = user
	src.components -= removing
	if(removing == src.modChassis) //will figure out how to make this cleaner at some point
		src.modChassis = null
	if(removing == src.modChamber)
		src.modChamber = null
	if(removing == src.modDriver)
		src.modDriver = null
	if(removing == src.modLoader)
		src.modLoader = null
	if(removing == src.modBarrel)
		src.modBarrel = null
	if(removing == src.modSight)
		src.modSight = null
	if(removing == src.modStock)
		src.modStock = null
	if(removing == src.modAttachment)
		src.modAttachment = null
	user << "\red You remove the [removing] from the frame."

/*	var/obj/item/weapon/cell/power_supply //What type of power cell this uses
	var/charge_cost = 200 //How much energy is needed to fire.
	var/max_shots = 10 //Determines the capacity of the weapon's power cell. Specifying a cell_type overrides this value.
	var/cell_type = null
	var/projectile_type = /obj/item/projectile/beam/practice
	var/modifystate
	var/charge_meter = 1	
	*/
/obj/item/weapon/modular_firearms/assembly/proc/compile(mob/user as mob)
	var/type = null
	if(src.isKinetic)
		var/new/obj/item/weapon/gun/MFCS/projectile/P as obj
		type = 1
	if(src.isEnergy)
		var/new/obj/item/weapon/gun/MFCS/energy/P as obj
		type = 2
	P.modChassis = src.modChassis
	P.modChamber = src.modChamber
	if(type = 1)
		if(src.caliber)
			P.caliber = src.caliber
	if(type = 2)
		if(src.projectile_type)
			P.projectile_type = src.projectile_type
			P.charge_cost = src.modChamber.charge_cost
	P.modLoader = src.modLoader
	var/load = src.modLoader
		if(!load.Eloader)
			P.max_shells = load.max_shells
			P.load_method = load.load_method
			P.handle_casings = load.handle_casings
	
			
		

//Will be used for procs instead


/obj/item/weapon/modular_firearms/assembly/proc/process_part(obj/item/I as obj, mob/user as mob) //this should handle processing new parts in the weapon, without relying on the weapon actually being attacked.
	if(istype(I, /obj/item/weapon/modular_firearms/chassis))
		if(istype(I, /obj/item/weapon/modular_firearms/chassis/energy))
			src.isEnergy = 1
		if(istype(I, /obj/item/weapon/modular_firearms/chassis/ballistic))
			src.isKinetic = 1
		modChassis = I
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
	if(istype(I, /obj/item/weapon/modular_firearms/driver))
		var/obj/item/weapon/modular_firearms/driver/D = I
		if(D.firemodes)
		else
			src.msg = "\red Have you considered using a real driver?"
			return
		src.modDriver = I
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
	if(istype(I, /obj/item/weapon/modular_firearms/barrel))
		var/obj/item/weapon/modular_firearms/barrel/B = I
		src.modBarrel = I
	if(istype(I, /obj/item/weapon/modular_firearms/stock))
		src.modStock += I
	if(istype(I, /obj/item/weapon/modular_firearms/sight))
		src.modSight += I
	
/obj/item/weapon/modular_firearms/assembly/proc/add_part(obj/item/I as obj, mob/user as mob, var/part, var/prereq) //Handles all part processing in a single proc. So clean~
	if(part)
		if(part in src.components)
			user << "\red There is already a [part] installed!"
			return
	else
		user << "\red Error - null part variable for [I]"
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

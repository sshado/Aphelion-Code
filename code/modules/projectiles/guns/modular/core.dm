//Will be used for procs instead


/obj/item/weapon/modular_firearms/assembly/proc/process_part(obj/item/I as obj, mob/user as mob) //this should handle processing new parts in the weapon, without relying on the weapon actually being attacked.	if(istype(I, /obj/item/weapon/modular_firearms/chassis)) 
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
				user << "\red A ballistic chamber won't work with an energy chassis!"
				return
		if(chamber.caliber) //checking for kinetic weaponry
			if(src.isKinetic)
			else
				user << "\red An energy chamber won't work with a ballistic chassis!"
				return
		src.modChamber = I
	if(istype(I, /obj/item/weapon/modular_firearms/driver))
		var/obj/item/weapon/modular_firearms/driver/D = I
		if(D.firemodes)
		else
			user << "\red How did you manage this?"
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
		src.accuracy_mod += B.accuracy_mod
		src.weight += B.weight
		if(B.burst_mod) //dear lord
			src.burst_mod += B.burst_mod
		src.modBarrel += B
	if(istype(I, /obj/item/weapon/modular_firearms/stock))
		src.modStock += I
	if(istype(I, /obj/item/weapon/modular_firearms/sight))
		src.modSight += I
	
/obj/item/weapon/modular_firearms/assembly/proc/add_part(obj/item/I as obj, mob/user as mob) //Handles all part processing in a single proc. So clean~
	user.drop_item()
	I.loc = src
	src.components += I
	src.process_part(I, user)

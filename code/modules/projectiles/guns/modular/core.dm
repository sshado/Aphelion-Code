//Will be used for procs instead


/obj/item/weapon/modular_firearms/assembly/proc/process_part(obj/item/I as obj, mob/user as mob) //this should handle processing new parts in the weapon, without relying on the weapon actually being attacked.	if(istype(I, /obj/item/weapon/modular_firearms/chassis)) 
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
	
/obj/item/weapon/modular_firearms/assembly/proc/add_part(obj/item/I as obj, mob/user as mob) //Handles all part processing in a single proc. So clean~
	user.drop_item()
	I.loc = src
	components += I
	process_part(I, user)

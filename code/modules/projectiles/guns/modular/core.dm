//MFCS procs -- Cirra

/obj/item/weapon/modular_firearms/assembly/proc/debug(var/part as var, var/type as var)
	user << "<span class="info">DEBUG: [part] is current [type]</span>"

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
				src.msg = "<span class="warning"> A ballistic chamber won't work with an energy chassis!</span>"
				return
		if(chamber.caliber) //checking for kinetic weaponry
			if(src.isKinetic)
			else
				src.msg = "<span class="warning"> An energy chamber won't work with a ballistic chassis!</span>"
				return
		src.modChamber = I
		src.removable -= src.modChassis //removes its source part from the removable list.
		src.removable += I
	if(istype(I, /obj/item/weapon/modular_firearms/driver))
		var/obj/item/weapon/modular_firearms/driver/D = I
		if(D.firemodes)
		else
			src.msg = "<span class="warning"> Have you considered using a real driver?</span>" //this will usually only be returned if
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
			user << "<span class="warning"> There is already a [part] installed!</span>"
			return
	else
		user << "<span class="warning"> Error - null part variable for [I].</span>" //for debugging
		return
	if(prereq)
		if(!prereq in src.components)
			user << "<span class="warning"> The [I] needs to be attached to a [prereq]!</span>"
			return
	src.process_part(I, user)
	if(!src.msg)
		src.msg = ("<span class="info">\blue You install the [I] onto the [src]."</span>)
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
	user << "<span class="warning"> You remove the [removing] from the frame.</span>"

/*	var/obj/item/weapon/cell/power_supply //What type of power cell this uses
	var/charge_cost = 200 //How much energy is needed to fire.
	var/max_shots = 10 //Determines the capacity of the weapon's power cell. Specifying a cell_type overrides this value.
	var/cell_type = null
	var/projectile_type = /obj/item/projectile/beam/practice
	var/modifystate
	var/charge_meter = 1	
	*/
	
/obj/item/weapon/modular_firearms/assembly/proc/compile(mob/user as mob)
    	var/obj/item/weapon/gun/MFCS/P // Declares but does not instantiate a variable or create the object.
    	src.compiled = 1
    	if(src.mastertype)
    		P = new mastertype(loc)
    	else 
    		if(src.isKinetic)
        		P = new obj/item/weapon/gun/MFCS/projectile(loc) // Previously declared variable refers to this object.
    		else if(src.isEnergy)
        		P = new obj/item/weapon/gun/MFCS/energy(loc) // As above, different path, shared parent type.
    	P.modChassis = src.modChassis //etc. Credit to Zuhayr for the above.
	P.modChamber = src.modChamber
	if(src.caliber)
		P.caliber = src.caliber
	else
		P.projectile_type = src.projectile_type
		P.charge_cost = src.modChamber.charge_cost
	P.modLoader = src.modLoader
	var/load = src.modLoader
		if(!load.Eloader)
			if(!P.max_shells)
				P.max_shells = load.max_shells
			P.load_method = load.load_method
			P.handle_casings = load.handle_casings
		else
			P.cell = new/obj/item/weapon/cell(P) //Initializes a powercell inside of the energy weapon.
	P.modDriver = src.modDriver
	var/driver = src.modDriver
	for(datum/firemode/F in driver.firemodes())
		P.firemodes += F //adds each firemode from the driver to the gun
	P.modBarrel = src.modBarrel
	var/barrel = src.modBarrel
	if(barrel.burst_mod) //checking if it's some kind of special barrel such as double or rotating
		for(datum/firemode/F in P.firemodes())
			F.burst += barrel.burst_mod //should add the number of extra shots to each firemode the gun has
	if(src.modStock)
		P.modStock = src.modStock
		var/stock = src.modStock
		if(stock.folding)
			P.stockmessage = "<span class="notice">You fold away the [modStock]</span>"
		else if(stock.telescopic)
			P.stockmessage = "<span class="notice">You collapse the [modStock]</span>"

	for(obj/item/I in P.contents()) //so I don't have to repeat these lines every time something modifies them
		if(I.accuracy_mod)
			P.accuracy += I.accuracy_mod
		if(I.weight) //will be used to calculate w_class
			P.weight += I.weight
		if(I.overlays) //critical component of the upcoming modular sprite system
			if(!P.compilesprite)
				P.overlays += I.overlays
			else
				I.overlays = list()
				P.icon_state = P.compilesprite
		if(I.recoil_mod)
			P.recoil += I.recoil_mod
			
		src.debug(I, I.name)

//Barrels define the range of the weapon, as well as affecting their accuracy.
//For energy weapons, this refers to focusing chambers.

obj/item/weapon/modular_firearms/barrel
	name = "barrel"
	icon = 'icons/placeholder.dmi'
	var/accuracy_mod = null
	var/weight = null
	var/burst_mod = null
	
obj/item/weapon/modular_firearms/barrel/sniper
	name = "marksman barrel"
	accuracy_mod = 1
	weight = 4
	
obj/item/weapon/modular_firearms/barrel/rifle
	name = "long barrel"
	accuracy_mod = 0.5
	weight = 3
	
	
obj/item/weapon/modular_firearms/barrel/standard
	name = "standard barrel"
	accuracy_mod = 0
	weight = 2
	
obj/item/weapon/modular_firearms/barrel/short
	name = "short barrel"
	accuracy_mod = -0.5
	weight = 1
	
obj/item/weapon/modular_firearms/barrel/snub
	name = "snub barrel"
	accuracy_mod = -1
	weight = 0
	
obj/item/weapon/modular_firearms/barrel/rotating //boom goes your accuracy. Good luck getting one though
	name = "rotating barrel"
	accuracy_mod = -3
	weight = 5
	burst_mod = 5
	
obj/item/weapon/modular_firearms/barrel/double
	name = "double barrel"
	accuracy_mod = -1
	weight = 2
	burst_mod = 2
	
obj/item/weapon/modular_firearms/barrel/triple 
	name = "triple barrel"
	accuracy_mod = -2
	weight = 3
	burst_mod = 3
	
	/*	//Not quite sure about energy barrels yet.
obj/item/weapon/modular_firearms/barrel/energy
	var/power_mod = null
	

obj/item/weapon/modular_firearms/barrel/energy/long
	name = "high-refraction focusing chamber"
	accuracy_mod = 2
	weight = 3
	power_mod = 4
	
obj/item/weapon/modular_firearms/barrel/energy/high
	name = "dense focusing chamber"
	accuracy_mod = 1
	weight = 2
	power_mod = 3
	
obj/item/weapon/modular_firearms/barrel/energy/heavy
	name = "heavy focusing chamber"
	accuracy_mod = 0
	weight = 4
	power_mod = 5
	var/heavyfocus = 1
	
obj/item/weapon/modular_firearms/barrel/energy/standard
	name = "regulated focusing chamber"
	accuracy_mod = 0
	weight = 1
	power_mod = 2
	
obj/item/weapon/modular_firearms/barrel/energy/standard
	name = "simple focusing chamber"
	accuracy_mod = 0
	weight = 0.5
	power_mod = 1
	
	*/
	
	
	
	
	

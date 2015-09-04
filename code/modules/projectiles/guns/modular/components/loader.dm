//Loaders are how the gun handles ammuni

obj/item/weapon/modular_firearms/loader
	icon = 'icons/placeholder.dmi'
	var/load_method = null
	var/isbolt = null
	
obj/item/weapon/modular_firearms/loader/magazine
	name = "magazine loader"
	load_method = MAGAZINE
	handle_casings = EJECT_CASINGS
	
obj/item/weapon/modular_firearms/loader/speedloader
	name = "speedloader"
	load_method = SPEEDLOADER
	handle_casings = EJECT_CASINGS
	
obj/item/weapon/modular_firearms/loader/shell
	name = "shell loader"
	load_method = SINGLE_CASING
	handle_casings = HOLD_CASINGS
	var/max_shells = 4
	
obj/item/weapon/modular_firearms/loader/combat //lockbox
	name = "combat shell loader"
	load_method = SINGLE_CASING
	handle_casings = HOLD_CASINGS
	var/max_shells = 7
	
obj/item/weapon/modular_firearms/loader/bolt
	name = "bolt loader"
	load_method = SINGLE_CASING
	handle_casings = HOLD_CASINGS
	max_shells = 1
	isbolt = 1

//Loaders are how the gun handles ammuni

obj/item/weapon/modular_firearms/loader
	icon = 'icons/placeholder.dmi'
	var/load_method = null
	var/isbolt = null
	var/useCell = null
	var/useSupply = null
	var/Eloader = null
	var/max_shells = null
	var/handle_casings = null
	
obj/item/weapon/modular_firearms/loader/magazine
	name = "magazine loader"
	load_method = MAGAZINE
	handle_casings = EJECT_CASINGS
	
obj/item/weapon/modular_firearms/loader/speedloader
	name = "speedloader"
	load_method = SINGLE_CASING|SPEEDLOADER
	handle_casings = EJECT_CASINGS
	
obj/item/weapon/modular_firearms/loader/shell
	name = "shell loader"
	load_method = SINGLE_CASING
	handle_casings = HOLD_CASINGS
	max_shells = 4
	
obj/item/weapon/modular_firearms/loader/shell/combat //lockbox
	name = "combat shell loader"
	max_shells = 7
	
obj/item/weapon/modular_firearms/loader/bolt
	name = "bolt loader"
	load_method = SINGLE_CASING
	handle_casings = HOLD_CASINGS
	max_shells = 1
	isbolt = 1
	
obj/item/weapon/modular_firearms/loader/powersupply
	name = "internal power supply"
	icon = 'icons/placeholder.dmi'
	useSupply = 1
	Eloader = 1
	var/celltype = /obj/item/weapon/cell
	var/cooler = null

obj/item/weapon/modular_firearms/loader/powersupply/verylow
	name = "WT-500 power supply"
	desc = "Powered with an AA battery. This is pretty awful."
	celltype = /obj/item/weapon/cell/crap

obj/item/weapon/modular_firearms/loader/powersupply/low
	name = "WT-1000 power supply"
	celltype = /obj/item/weapon/cell/device
	
obj/item/weapon/modular_firearms/loader/powersupply/med
	name = "WT-2000 power supply"
	celltype = /obj/item/weapon/cell
	
obj/item/weapon/modular_firearms/loader/powersupply/high
	name = "WT-5000 power supply."
	celltype = /obj/item/weapon/cell/apc

//Drivers affect how the gun fires. Does it use burst fire? Automatic? Semi? Charge?

/*/datum/firemode/modular
	name = "modular-default"
	burst = 1
	burst_delay = null
	fire_delay = null
	move_delay = 1
	list/accuracy = list(0)
	list/dispersion = list(0)
	*/

obj/item/weapon/modular_firearms/driver
	icon = 'icons/placeholder.dmi'
	var/burst = 1
	var/burst_delay = null
	var/fire_delay = null
	var/move_delay = 1
	var/list/accuracy = list(0)
	var/list/dispersion = list(0)
	
obj/item/weapon/modular_firearms/driver/autoinacc
	name = "rapid-automatic driver"
	icon = 'icons/placeholder.dmi'
	var/burst = 7
	var/burst_delay = null
	var/fire_delay = null
	var/move_delay = 1
	var/list/accuracy = list(0)
	var/list/dispersion = list(1.5)

obj/item/weapon/modular_firearms/driver/semiauto
	name = "semi-automatic driver"
	icon = 'icons/placeholder.dmi'
	var/burst = 1
	var/burst_delay = null
	var/fire_delay = null
	var/move_delay = 1
	var/list/accuracy = list(0)
	var/list/dispersion = list(0)
	
obj/item/weapon/modular_firearms/driver/burst3
	name = "burst driver"
	icon = 'icons/placeholder.dmi'
	var/burst = 3
	var/burst_delay = null
	var/fire_delay = null
	var/move_delay = 1
	var/list/accuracy = list(0)
	var/list/dispersion = list(0.4)
	
obj/item/weapon/modular_firearms/driver/auto
	name = "automatic driver"
	icon = 'icons/placeholder.dmi'
	var/burst = 5
	var/burst_delay = null
	var/fire_delay = null
	var/move_delay = 1
	var/list/accuracy = list(0)
	var/list/dispersion = list(0.5)
	
obj/item/weapon/modular_firearms/driver/preciseburst
	name = "precision burst driver"
	icon = 'icons/placeholder.dmi'
	var/burst = 3
	var/burst_delay = 1
	var/fire_delay = null
	var/move_delay = 1
	var/list/accuracy = list(0)
	var/list/dispersion = list(0.2)

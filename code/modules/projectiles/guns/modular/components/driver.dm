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
	var/list/firemodes = list(
		list(name="semiauto", burst=1, fire_delay=0)
		)
	
obj/item/weapon/modular_firearms/driver/longburst
	name = "rapid-automatic driver"
	icon = 'icons/placeholder.dmi'
	firemodes = list(
		list(name="long bursts",	burst=8, move_delay=8, accuracy = list(0,-1,-1,-2,-2,-2,-3,-3), dispersion = list(1.0, 1.0, 1.0, 1.0, 1.2)),
		list(name="short bursts",	burst=5, move_delay=6, accuracy = list(0,-1,-1,-2,-2,-2,-3,-3), dispersion = list(0.6, 1.0, 1.0, 1.0, 1.2))
		)

obj/item/weapon/modular_firearms/driver/semiauto
	name = "semi-automatic driver"
	icon = 'icons/placeholder.dmi'
	
obj/item/weapon/modular_firearms/driver/burst3
	name = "burst driver"
	icon = 'icons/placeholder.dmi'
	firemodes = list(
		list(name="3-round bursts", burst=3, move_delay=6, accuracy = list(0,-1,-1), dispersion = list(0.0, 0.6, 0.6)),
		list(name="semiauto", burst=1, fire_delay=0)
		)
	
obj/item/weapon/modular_firearms/driver/burst5
	name = "5-burst driver"
	icon = 'icons/placeholder.dmi'
	firemodes = list(
		list(name="short bursts",	burst=5, move_delay=6, accuracy = list(0,-1,-1,-2,-2,-2,-3,-3), dispersion = list(0.6, 1.0, 1.0, 1.0, 1.2)),
		list(name="3-round bursts", burst=3, move_delay=6, accuracy = list(0,-1,-1), dispersion = list(0.0, 0.6, 0.6)),
		list(name="semiauto", burst=1, fire_delay=0)
		)

obj/item/weapon/modular_firearms/driver/z8
	name = "Z8 driver"
	firemodes = list(
		list(name="semiauto", burst=1, fire_delay=0),
		list(name="3-round bursts", burst=3, move_delay=6, accuracy = list(0,-1,-1), dispersion = list(0.0, 0.6, 0.6)),
		list(name="fire grenades", use_launcher=1)
		)

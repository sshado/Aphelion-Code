
/obj/item/weapon/gun/energy/modular
  name = "energy gun"
  desc = "Pew pew."
  var/modChassis = null
	var/modChamber = null
	var/modDriver = null
	var/modLoader = null
	var/modBarrel = null
	var/modStock = null
	var/modSight = null
	var/modMisc = list()
	var/weight = 1
	fire_delay = null
	burst_delay = null
	list/firemodes = list()
	accuracy = 0
	var/list/components = list()
	var/list/removable = list()

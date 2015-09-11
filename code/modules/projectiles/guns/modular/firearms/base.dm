/obj/item/weapon/gun/MFCS
  name = "modular gun template"
  desc = "Nothing to see here. Move along, citizen."
  var/modChassis = null
	var/modChamber = null
	var/modDriver = null
	var/modLoader = null
	var/modBarrel = null
	var/modStock = null
	var/modSight = null
	var/modMisc = list()
	var/weight = 1
	fire_delay
	burst_delay
	list/firemodes = list()
	accuracy = 0
	var/list/components = list()
	var/list/removable = list()
	var/useCell = null
	var/useSupply = null
	var/useBullet = null

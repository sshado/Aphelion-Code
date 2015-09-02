//The chamber decides what type of projectile the gun fires.
//For ballistic, there will be a chamber for each bullet type, along with cartridges and shotgun shells
//For energy, it will include each type of beam, excluding pulse weaponry. Heavy lasers may only be made with a heavy frame

obj/item/weapon/modular_firearms/chamber
	var/caliber = null
	var/projectile_type = null
	icon = 'icons/placeholder.dmi'

obj/item/weapon/modular_firearms/chamber/a357
	name = ".357 chamber"
	desc = "Compatible with .357"
	caliber = "357"

obj/item/weapon/modular_firearms/chamber/a50
	name = ".50 chamber"
	desc = "Compatible with .50"
	caliber = ".50"


obj/item/weapon/modular_firearms/chamber/c38
	name = ".38 chamber"
	desc = "Compatible with .38"
	caliber = "38"

obj/item/weapon/modular_firearms/chamber/a75
	name = ".75 chamber"
	desc = "Compatible with .75 ammunition."
	caliber = "75"

obj/item/weapon/modular_firearms/chamber/c9mm
	name = "9mm chamber"
	desc = "Compatible with 9mm ammunition."
	caliber = "9mm"

obj/item/weapon/modular_firearms/chamber/a12mm
	name = "12mm chamber"
	desc = "Compatible with 12mm ammunition."
	caliber = "12mm"

obj/item/weapon/modular_firearms/chamber/c45
	name = ".45 chamber"
	desc = "Compatible with .45 ammunition."
	caliber = ".45"

obj/item/weapon/modular_firearms/chamber/shotgun
	name = "shotgun chamber"
	desc = "Compatible with all shotgun-grade ammunition."
	caliber = "shotgun"

//obj/item/weapon/modular_firearms/chamber/stunshell
//	name = "taser cartridge system"
//	desc = "Compatible with Taser cartridges."
//	allowed_projectiles = list(/obj/item/projectile/energy/electrode/stunshot, /obj/item/projectile/energy/electrode)

obj/item/weapon/modular_firearms/chamber/a762
	name = ".762 chamber"
	desc = "Compatible with .762 ammunition."
	caliber = "a762"

obj/item/weapon/modular_firearms/chamber/a145
	name = ".145 chamber"
	desc = "Compatible with .145 ammunition."
	caliber = "14.5mm"

obj/item/weapon/modular_firearms/chamber/a556
	name = ".556 chamber"
	desc = "Compatible with .556 ammunition."
	caliber = "a556"

obj/item/weapon/modular_firearms/chamber/energy

obj/item/weapon/modular_firearms/chamber/energy/laser
	name = "laser emitter"
	projectile_type = /obj/item/projectile/beam

obj/item/weapon/modular_firearms/chamber/energy/plaser
	name = "practice laser emitter"
	projectile_type = /obj/item/projectile/beam/practice

obj/item/weapon/modular_firearms/chamber/energy/hlaser
	name = "heavy laser emitter"
	projectile_type = /obj/item/projectile/beam/heavylaser

obj/item/weapon/modular_firearms/chamber/energy/xray
	name = "X-ray laser emitter"
	projectile_type = /obj/item/projectile/beam/xray

obj/item/weapon/modular_firearms/chamber/energy/xsniper
	name = "sniper laser emitter"
	projectile_type = /obj/item/projectile/beam/sniper

obj/item/weapon/modular_firearms/chamber/energy/ltagblue
	name = "blue laser-tag emitter"
	projectile_type = /obj/item/projectile/beam/lastertag/blue

obj/item/weapon/modular_firearms/chamber/energy/ltagred
	name = "red laser-tag emitter"
	projectile_type = /obj/item/projectile/beam/lastertag/red

obj/item/weapon/modular_firearms/chamber/energy/stun
	name = "stun beam emitter"
	projectile_type = /obj/item/projectile/beam/stun

obj/item/weapon/modular_firearms/chamber/energy/ion
	name = "ion emitter"
	projectile_type = /obj/item/projectile/ion

obj/item/weapon/modular_firearms/chamber/energy/floramut
	name = "floral emitter"
	projectile_type = /obj/item/projectile/energy/floramut

obj/item/weapon/modular_firearms/chamber/energy/phoron
	name = "phoron emitter"
	projectile_type = /obj/item/projectile/energy/phoron


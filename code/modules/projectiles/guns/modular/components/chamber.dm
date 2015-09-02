//The chamber decides what type of projectile the gun fires.
//For ballistic, there will be a chamber for each bullet type, along with cartridges and shotgun shells
//For energy, it will include each type of beam, excluding pulse weaponry. Heavy lasers may only be made with a heavy frame

obj/item/weapon/modular_firearms/chamber
	var/list/allowed_projectiles = list()
	var/projectile_type = null

obj/item/weapon/modular_firearms/chamber/a357
	name = "heavy-pistol chamber"
	desc = "Compatible with .357 and .50 ammunition."
	allowed_projectiles = list(/obj/item/projectile/bullet/pistol/strong)

obj/item/weapon/modular_firearms/chamber/a75
	name = "gyrojet chamber"
	desc = "Compatible with .75 ammunition."
	allowed_projectiles = list(/obj/item/projectile/bullet/gyro)

obj/item/weapon/modular_firearms/chamber/c9mm
	name = "standard pistol chamber"
	desc = "Compatible with .38 and 9mm ammunition."
	allowed_projectiles = list(/obj/item/projectile/energy/flash/flare, /obj/item/projectile/bullet/pistol, /obj/item/projectile/energy/flash, /obj/item/projectile/bullet/pistol/rubber, /obj/item/projectile/bullet/pistol/practice)

obj/item/weapon/modular_firearms/chamber/c45
	name = "medium-pistol chamber"
	desc = "Compatible with .45 and 12mm ammunition."
	allowed_projectiles = list(/obj/item/projectile/bullet/pistol/medium)

obj/item/weapon/modular_firearms/chamber/shotgun
	name = "shotgun chamber"
	desc = "Compatible with all shotgun-grade ammunition."
	allowed_projectiles = list(/obj/item/projectile/energy/flash/flare, /obj/item/projectile/bullet/shotgun, /obj/item/projectile/bullet/pellet/shotgun, /obj/item/projectile/bullet/blank, /obj/item/projectile/bullet/shotgun/practice, /obj/item/projectile/bullet/shotgun/beanbag)

obj/item/weapon/modular_firearms/chamber/stunshell
	name = "taser cartridge system"
	desc = "Compatible with Taser cartridges."
	allowed_projectiles = list(/obj/item/projectile/energy/electrode/stunshot, /obj/item/projectile/energy/electrode)

obj/item/weapon/modular_firearms/chamber/a762
	name = ".762 chamber"
	desc = "Compatible with .762 ammunition."
	allowed_projectiles = list(/obj/item/projectile/bullet/rifle/a762)

obj/item/weapon/modular_firearms/chamber/a145
	name = ".145 chamber"
	desc = "Compatible with .145 ammunition."
	allowed_projectiles = list(/obj/item/projectile/bullet/rifle/a145)

obj/item/weapon/modular_firearms/chamber/a556
	name = ".556 chamber"
	desc = "Compatible with .556 ammunition."
	allowed_projectiles = list(/obj/item/projectile/bullet/rifle/a556)

obj/item/weapon/modular_firearms/chamber/energy
	allowed_projectiles = null

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
	allowed_projectiles = list()
	projectile_type = /obj/item/projectile/beam/xray

obj/item/weapon/modular_firearms/chamber/energy/xsniper
	name = "sniper laser emitter"
	allowed_projectiles = list()
	projectile_type = /obj/item/projectile/beam/sniper

obj/item/weapon/modular_firearms/chamber/energy/ltagblue
	name = "blue laser-tag emitter"
	allowed_projectiles = list()
	projectile_type = /obj/item/projectile/beam/lastertag/blue

obj/item/weapon/modular_firearms/chamber/energy/ltagred
	name = "red laser-tag emitter"
	allowed_projectiles = list()
	projectile_type = /obj/item/projectile/beam/lastertag/red

obj/item/weapon/modular_firearms/chamber/energy/stun
	name = "stun beam emitter"
	allowed_projectiles = list()
	projectile_type = /obj/item/projectile/beam/stun

obj/item/weapon/modular_firearms/chamber/energy/ion
	name = "ion emitter"
	allowed_projectiles = list()
	projectile_type = /obj/item/projectile/ion

obj/item/weapon/modular_firearms/chamber/energy/floramut
	name = "floral emitter"
	allowed_projectiles = list()
	projectile_type = /obj/item/projectile/energy/floramut

obj/item/weapon/modular_firearms/chamber/energy/phoron
	name = "phoron emitter"
	allowed_projectiles = list()
	projectile_type = /obj/item/projectile/energy/phoron


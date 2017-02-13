//Stocks affect the gun's accuracy and recoil, in the case of projectile weaponry.

obj/item/weapon/modular_firearms/stock
	icon = 'icons/placeholder.dmi'
	var/weight = null
	var/folding = null //can be folded away. Makes the weapon less unwieldy, but removes recoil bonus
	var/telescopic = null //can collapse. Slightly better but heavier than the folding stock
	var/recoil_mod = null
	
obj/item/weapon/modular_firearms/stock/comp
	name = "compound stock"
	recoil_mod = -2
	weight = 2
	
obj/item/weapon/modular_firearms/stock/fixed
	name = "fixed stock"
	recoil_mod = -1.5
	weight = 1.5
	
obj/item/weapon/modular_firearms/stock/folding
	name = "folding stock"
	recoil_mod = -1
	weight = 1
	folding = 1
	
obj/item/weapon/modular_firearms/stock/tele //telescopic everything
	name = "telescopic stock"
	recoil_mod = -1.5
	weight = 1.5
	telescopic = 1
	
obj/item/weapon/modular_firearms/stock/pistol
	name = "pistol stock"
	recoil_mod = -0.5
	weight = 0.5

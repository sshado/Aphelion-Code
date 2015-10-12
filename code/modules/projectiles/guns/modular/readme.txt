################################################################################################
# README - MODULAR FIREARM CONSTRUCTION SYSTEM
# ----------------------------------------------------------------------------------------------
# 1. Constructing firearms
# 2. Deconstructing firearms
# 3. Components
# 4. Overview of the finished product
# 5. Debugging
#
#
# --Constructing firearms--
# MFCS allows players to design new guns from an array
# of parts, in-game. These parts can be obtained by 
# cargo, or constructed by research, and will normally
# come in a HoS-locked box. Once the player has obtained
# enough of these components to create a new weapon, 
# they may "compile" the firearm after installing each
# part on the firearm's frame.
# 
#  Assembly
# In order to assemble a firearm, the user should obtain the parts they wish to use, starting with
# the "assembly." The type of assembly will indicate the size of the final weapon, as should be clear.
# In order to actually assemble the weapon, the player should follow the following steps.
#
# 1. Click on the assembly with a chassis in hand (ballistic/energy.) This will decide if the weapon
#  will fire beams or other energy projectiles, or if it will fire bullets. For now, there are only
#  Two types of chassis, although another may be coming in the future.
#
# 2. Click on the assembly with a chamber. This will decide what type of projectile the weapon will fire - 
#  If the assembly has a ballistic chassis attached, then the player may attach a chamber for any type of
#  bullet in the game. For energy chassis's, the player may do the same, but for any type of energy projectile
#  including lasers, x-ray, ion, phoron, et cetera. From this point, the steps may be carried out in a variety 
#  of different orders. It should be noted that in the case of ballistic weapons, this step also decides the
#  calibre of the weapon. At this point, the chassis may no longer be removed.
#
# 3. Click on the assembly with either a barrel, a driver, or a loader.
#  i) If the player attaches a barrel at this stage, then this will decide the accuracy of the weapon. This
#   does not affect the accuracy levels of each firemode, however. Once a barrel is attached, the chamber may not be removed.
#  ii) If the player attaches a driver at this stage, then this will decide how the weapon fires. Each driver represents a set
#   of firemodes, which will be applied to the final weapon. For instance, the player may attach a longburst driver if they wish
#   to replicate the functionality of a SAW, while a semi-automatic driver will act like most pistols in the game. As
#   should be obvious, it would be very foolish to attach a driver which allows for longer bursts than the weapon is
#   capable of, due to its capacity. Once this part is attached, the chamber may not be removed.
#  iii) If the player attaches a loader at this stage, then this will decide how the weapon can be loaded with ammunition. 
#   care should be taken to ensure that the player does not install a loader with a lower capacity than the weapon's firemodes,
#   such as a bolt loader with a fully automatic weapon. In the case of an energy weapon, this step will decide on the size
#   of the firearm's power supply. Depending on the chosen loader, the weapon will then accept
#   any ammunition of the same calibre as the weapon itself, as long as that ammunition is delivered with the correct loading
#   procedure. For instance, a weapon with a magazine loader will accept any magazines with ammunition of the same calibre
#   as that defined by the chamber. As with the other two options, carrying out this step will render the chamber unremovable.
#  step 3 can be carried out until all three parts are installed. 
#
# 4. (optional) Click on the assembly with either a stock or a scope.
#  i) If the player attaches a stock at this stage, then this will affect the recoil of the weapon in question, usually reducing
#   it. In some cases, the stock will be able to be folded, at which point the weapon will display a message and the W_class will
#   be reduced by one. In all cases, having the stock attached and/or extended will increase the W_class of the firearm by 1.
#  ii) If the player attaches a scope at this stage, then this will have two effects. If the scope is some kind of long-range
#   sniper's scope, this will allow the player to zoom, as they can with any sniper rifle in the game. Their accuracy in this
#   mode will be affected by the barrel and firemode in use. If the scope is of any other kind, this will affect the accuracy
#   of the weapon when unscoped. For instance, a red-dot sight will slightly increase the accuracy of the weapon, in comparison
#   to standard iron sights.
#
# 5. Click on the assembly with a screwdriver. This will complete the weapon, and put it into the hands of the player. Note that
#  doing this while the weapon is already compiled will dissasemble it, and the process must be restarted.
#
#  ----------------------------
#           assembly
#              |
#           chassis
#            | | | 
#    stock  _| | |_ scope
#           chamber 
#            | | |
#    driver _| | |_ barrel
#            loader
# -----------------------------
#
# Fig. 1 - The tree of parts in a firearm. All parts that are linked to others futher down the tree may not be removed
# until all of the further-down parts are removed 

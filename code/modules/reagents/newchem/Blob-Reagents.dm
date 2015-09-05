// These can only be applied by blobs. They are what blobs are made out of.
// The 4 damage
/datum/reagent/blob
	var/message = "The blob strikes you" //message sent to any mob hit by the blob
	var/message_living = null //extension to first mob sent to only living mobs i.e. silicons have no skin to be burnt

/datum/reagent/blob/toxic_goop
	name = "Toxic Goop"
	id = "toxic_goop"
	description = ""
	color = "#008000"
	message_living = ", and you feel sick and nauseated"

/datum/reagent/blob/toxic_goop/reaction_mob(var/mob/living/M as mob, var/method=TOUCH, var/volume)
	if(method == TOUCH)
		var/ratio = volume/25
		M.apply_damage(20*ratio, TOX)

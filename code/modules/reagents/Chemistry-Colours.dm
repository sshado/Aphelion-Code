/*
 * Returns:
 * 	#RRGGBB(AA) on success, null on failure
 */
/proc/mix_color_from_reagents(const/list/reagent_list)
	if(!istype(reagent_list))
		return

	var/color
	var/reagent_color
	var/vol_counter = 0
	var/vol_temp
	// see libs/IconProcs/IconProcs.dm
	for(var/datum/reagent/reagent in reagent_list)
		if(reagent.id == "blood" && reagent.data["blood_colour"])
			reagent_color = reagent.data["blood_colour"]
		else
			reagent_color = reagent.color

		vol_temp = reagent.volume
		vol_counter += vol_temp

		if(isnull(color))
			color = reagent.color
		else if(length(color) >= length(reagent_color))
			color = BlendRGB(color, reagent_color, vol_temp/vol_counter)
		else
			color = BlendRGB(reagent_color, color, vol_temp/vol_counter)
	return color

/datum/reagents/proc/get_color()
	if(!reagent_list || !reagent_list.len)
		return "#ffffffff"
	if(reagent_list.len == 1) // It's pretty common and saves a lot of work
		var/datum/reagent/R = reagent_list[1]
		return R.color

	var/list/colors = list(0, 0, 0, 0)
	var/tot_w = 0
	for(var/datum/reagent/R in reagent_list)
		var/hex = uppertext(R.color)
		if(length(hex) == 7)
			hex += "FF"
		if(length(hex) != 9) // PANIC PANIC PANIC
			warning("Reagent [R.id] has an incorrect color set ([R.color])")
			hex = "#FFFFFFFF"
	return rgb(colors[1] / tot_w, colors[2] / tot_w, colors[3] / tot_w, colors[4] / tot_w)

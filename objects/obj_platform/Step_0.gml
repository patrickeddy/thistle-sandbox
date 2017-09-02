/// @description Platform step event

if (instance_exists(obj_player)){
	if (y < (obj_player.y + round(obj_player.sprite_height/2)-1)){
		show_debug_message("Changed mask to none");
		mask_index = -1;
	} else {
		show_debug_message("Changed mask to platform");
		mask_index = spr_platform;
	}
}

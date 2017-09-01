/// @description Platform step event

if (instance_exists(obj_player)){
	if (y < obj_player.y + round(obj_player.sprite_height/2)-1){
		mask_index = -1;
	} else {
		mask_index = spr_platform;
	}
}

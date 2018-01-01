/// @description Spore logic

if (object_exists(obj_player) && place_meeting(x, y, obj_player)) {
	obj_player.spd -= 10;
	instance_destroy();
}

if (place_meeting(x, y, obj_wall)) {
	instance_destroy();	
}
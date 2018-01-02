/// @description Insert description here
// You can write your code in this editor

if (object_exists(obj_player) && place_meeting(x, y, obj_player)) {
	obj_player.hpiece_count++;	
	instance_destroy();
}
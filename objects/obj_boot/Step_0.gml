/// @description Insert description here
// You can write your code in this editor

if (object_exists(obj_player) && place_meeting(x, y, obj_player) && picked_up == false) {
	obj_player.jumpspd *= 1.25;	
	picked_up = true;
	instance_destroy();
}
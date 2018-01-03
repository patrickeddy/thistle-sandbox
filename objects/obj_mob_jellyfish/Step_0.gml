/// @description Insert description here
// You can write your code in this editor

if (instance_exists(obj_player) && 
	distance_to_object(obj_player) < 400) {
		var line_to_player = point_direction(x, y, obj_player.x, obj_player.y);
		direction = line_to_player;
		image_angle = line_to_player - 90;
		speed = 4;
}

if (place_meeting(x, y, obj_player)) {
	if (obj_player.attacking) {
		instance_destroy();
		drop_item(x, y, obj_heart_piece, 25);
	} else {
		// stun player for .75 seconds
		stun_player(.75);
		obj_player.hp--;
		instance_destroy();
	}
}
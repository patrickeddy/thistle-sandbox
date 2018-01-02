///damage_player()

if (object_exists(obj_player)) {
	var cooldown = 1; // cooldown in secs
	
	if (obj_player.hit_cooldown == 0) {
		obj_player.hp--; // damage player 1 hp
		obj_player.hit_cooldown = cooldown * room_speed;
	}
	if (obj_player.hp == 0) { room_restart(); } // restart the room if died.
}
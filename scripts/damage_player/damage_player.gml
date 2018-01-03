///damage_player()

if (object_exists(obj_player)) {
	var cooldown = 1; // cooldown in secs
	
	if (obj_player.hit_cooldown == 0) {
		obj_player.hp--; // damage player 1 hp
		obj_player.hit_cooldown = cooldown * room_speed;
	}
	// TODO remove audio_stop_all call
	if (obj_player.hp == 0) { audio_stop_all();room_restart(); } // restart the room if died.
}
/// @description Frame-dependent modified vars
// You can write your code in this editor

if (spd < MIN_SPEED) {
	spd = MIN_SPEED;
}

if (spd < MAX_SPEED) {
	spd += SPEED_REGENERATE;	
}

if (spd > MAX_SPEED) {
	spd = MAX_SPEED;	
}

if (hpiece_count == 5) {
	max_hp++;
	hp = max_hp;
	hpiece_count = 0;
}

if (stunned == true) {
	if (stun_counter == 0) {
		// this case only takes place on the first initial stun
		stun_counter = room_speed / (1 / STUN_RECOVER);
	} else {
		stun_counter--;
		show_debug_message("Stun:" + string(stun_counter));
		if (stun_counter <= 0) {
			// this case only takes place at the end of a stun
			stunned = false;
			stun_counter = 0;
		}
	}
}

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
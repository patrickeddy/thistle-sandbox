/// @description Breaks the crystal if attacking.

if (obj_player.attacking
	&& !broken){
	broken = true;
	sprite_index = spr_heart_crystal_broken;
	if (obj_player.hp < obj_player.max_hp) { obj_player.hp += 1; }
}
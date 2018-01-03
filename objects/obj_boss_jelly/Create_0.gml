/// @description Insert description here
// You can write your code in this editor

hurtbox = draw_hurtbox(384, 128, -192, -192, true);
hitbox = draw_hitbox(384, 256, -192, -64, true);

enum attack_phase {
	spawn_jellies,
	fire_ma_lazer,
	recharge,
	float_up,
	// initial phases is used when spawning.
	// once player is in range, this is an invalid state
	initial
}

// first iteration through the attack phases
repetition = 1;
current_phase = attack_phase.initial;
cooled_down = true;

jelly_minions = ds_list_create();



// this makes the 
phase_waiter = 0;

hp = 12;


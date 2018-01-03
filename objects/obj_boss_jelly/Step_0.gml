/// @description Insert description here
// You can write your code in this editor

phase_waiter--;

if (phase_waiter > 0) exit

// INITIAL PHASE //
if (current_phase == attack_phase.initial) {
	if (distance_to_object(obj_player) < 500) {
		current_phase = attack_phase.spawn_jellies;	
		audio_stop_all();
		audio_play_sound(boss_jelly_music, 0, 0);
	}
}
// SPAWN JELLIES PHASE //
if (current_phase == attack_phase.spawn_jellies) {
	// implemented using a list so we can trigger next phase when one minion is killed
	if(ds_list_size(jelly_minions) < repetition + 2) {
		var new_jelly = instance_create_depth(
			x + random_range(-200, 200),
			y + random_range(-100, 100),
			10,
			obj_mob_jellyfish);
		ds_list_add(jelly_minions, new_jelly);
		phase_waiter = room_speed / (1 / 2);
	} else {
		ds_list_clear(jelly_minions);
		current_phase = attack_phase.recharge;
	}
}

// FIRE LAZER PHASE //

if (current_phase == attack_phase.fire_ma_lazer) {
	
	var point_x = x;
	var point_y = y + 200;
	
	var firing_direction = point_direction(point_x, point_y, obj_player.x, obj_player.y);
	
	// one block for first time fire
	
	// another block for changing direction while firing
	
	draw_circle(point_x, point_y, 20, 1);
	
	for (var i = 0; i < 10000; i++) {
		var lx = point_x + lengthdir_x(i, firing_direction);
		var ly = point_y + lengthdir_y(i, firing_direction);
		
		if (collision_point(lx, ly, obj_wall, false, true)) {
			break;	
		}
	}
	
	draw_line(point_x, point_y, lx, ly);
}

if (current_phase == attack_phase.recharge) {
	y += 5;
	if(place_meeting(x, y, obj_wall)){
		while(place_meeting(x,y, obj_wall)) {
			y--	
		}
		// wait for 5 seconds
		phase_waiter = room_speed / (1 / 5);
		current_phase = attack_phase.float_up;
	}
}

if (current_phase == attack_phase.float_up) {
	y -= 6;
	if (place_meeting(x, y, obj_wall)) {
		while(place_meeting(x, y, obj_wall)) {
			y++	
		}
		current_phase = attack_phase.spawn_jellies;
	}
}

with(hurtbox) {
	x = other.x + offset_x;
	y = other.y + offset_y
}
with(hitbox) {
	x = other.x + offset_x;
	y = other.y + offset_y;
}

if (hurtbox.is_hit) {
	image_blend = c_red;
	hurtbox.is_hit = false;
	hp -= hurtbox.damage;
}

if (hp <= 0) {
	instance_destroy();	
}
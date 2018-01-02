/// @description Player movement and animation.

// get input
haxis = gamepad_axis_value(0, gp_axislh);
left = -((haxis == -1) || keyboard_check(ord("A")));
right = (haxis == 1) || keyboard_check(ord("D"));
jump = gamepad_button_check_pressed(0, gp_face1) || keyboard_check_pressed(vk_space);
jump_down = gamepad_button_check(0, gp_face1) || keyboard_check(vk_space);
jump_release = gamepad_button_check_released(0, gp_face1) || keyboard_check_released(vk_space);
attack = gamepad_button_check(0, gp_face3) || keyboard_check(vk_enter);
dash = gamepad_button_check_pressed(0, gp_shoulderlb) 
	|| gamepad_button_check_pressed(0, gp_shoulderrb) 
	|| keyboard_check_pressed(vk_shift);

show_debug_message("left: " + string(left));
show_debug_message("right: " + string(right));
show_debug_message("jump: " + string(jump));
show_debug_message("attack: " + string(attack))
show_debug_message("dash: " + string(dash))

// figure out the movement direction
if (left + right == 0) { // if we're not actively moving horizontally, and we're not walljumping
	if (!attacking) sprite_index = spr_player;
	if (!walljumping){
		hsp = 0;
	}
} else {
	walljumping = false; // cancel walljumping
	if (abs(hsp) < HSP_CAP * .2){ // if 20% of the cap
		 hsp += (left + right) * spd * AIR_FRICTION; // move sideways with some friction
	} else {
		hsp = (left + right) * spd; // move normal speed
	}
	if (!attacking) sprite_index = spr_player_running;
	if (hsp > 0) image_xscale = 1;
	if (hsp < 0) image_xscale = -1; // flip if moving left
}

// dash
if (dashing){
	dashcounter++;
	// tell little thistle that she can't dash forever, silly
	if (dashcounter / room_speed < DASH_COOLDOWN) { 
		hsp = hsp + sign(hsp) * dashspd;
	} else {
		dashing = false;
	}
} else if (dash) {
	dashcounter = 0;
	dashing = true;
}



// attacking logic
if (attacking){
	attackcounter += 1;
}

// if hit attack while not attacking (fresh)
if (attack 
	&& (attackcounter == 0)){
	attacking = true;
	attackpress += 1;
	sprite_index = spr_player_sword_attack;
	
}

// stage2 of attack
if (attack
	&& attackpress == 1
	&& (attackcounter/room_speed) >= STAGE_2_ATTACK_WINDOW){
	sprite_index = spr_player_sword_attack2;
	attackpress += 1;
}

// stage3 of attack
if (attack
	&& attackpress >= 2
	&& (attackcounter/room_speed) >= (STAGE_2_ATTACK_WINDOW + STAGE_3_ATTACK_WINDOW)){
	sprite_index = spr_player_sword_attack3;
	attackpress += 1;
}

third_attack = (attackpress == 3 && (attackcounter/room_speed) >= (STAGE_2_ATTACK_WINDOW + STAGE_3_ATTACK_WINDOW + STAGE_3_LENGTH));
second_attack = (attackpress >= 2
	&& (attackcounter/room_speed) >= STAGE_2_ATTACK_WINDOW + STAGE_2_LENGTH);
first_attack = (attackpress == 1
	&& (attackcounter/room_speed) >= STAGE_1_LENGTH);

// end after animations
if (first_attack
	|| second_attack
	|| third_attack
	|| (attackcounter/room_speed) > ATTACK_TIMEOUT) { 
	sprite_index = spr_player;
	attacking = false;
	attackcounter = 0;
	attackpress = 0;
}

// hp related
if (hit_cooldown != 0) { 
	hit_cooldown--; 
	image_blend = c_red;
} else {
	image_blend = -1;	
}


// add some gravity
if (vsp < grav){ // if on the down side of the jump curve
	if (vsp + grav < VSP_CAP) vsp += grav; // normal gravity
} else {
	if (vsp + 1.25 * grav < VSP_CAP) vsp += 1.5 * grav; // heavy gravity
}

// double jump
if (jump_release) { jumpcounter++; }
if (jumpcounter == 1 && jump_down){
	jumpcounter++;
	vsp = -jumpspd;
}

// enable jump
if (!jumping 
	&& ((place_meeting(x, y + 1, obj_wall) && jump)// wall below
	||  (place_meeting(x+(sprite_width/2), y, obj_wall) || place_meeting(x-(sprite_width/2), y, obj_wall)) && jump && walljumpcounter == 0)) { // wall beside
	vsp = -jumpspd;
	// if walljumping, add some jump 'knock'
	if (!(place_meeting(x, y + 1, obj_wall))){ // make sure we're in the air
		jumpcounter = 0; // disable the double jump while wall jumping
		walljumping = true;
		walljumpcounter = WALLJUMP_COOLDOWN;
		if (place_meeting(x-1, y, obj_wall)){ // walljump left side
			show_debug_message("Eyyy - wall left side!");
			hsp = +WALLJUMP_KNOCK;
			vsp = -WALLJUMP_KNOCK;
			sprite_index = spr_player_walljump; 
			image_xscale = -1;
		}
		if (place_meeting(x+1, y, obj_wall)){ // walljump right side
			show_debug_message("Eyyy - wall right side!");
			hsp = -WALLJUMP_KNOCK;
			vsp = -WALLJUMP_KNOCK;
			sprite_index = spr_player_walljump;
			image_xscale = 1;
		}
	}
}

if (walljumpcounter > 0) walljumpcounter--;


// wall collision - vertical
if (place_meeting(x, y + vsp, obj_wall)){
	while (!place_meeting(x, y + sign(vsp), obj_wall)){
		y += sign(vsp);
	}
	if (sign(vsp) > 0) { jumpcounter = 0; } // reset the jump counter if touched the ground
	vsp = 0;
	walljumping = false;
}	
	
// wall collision - horizontal
if (place_meeting(x + hsp, y, obj_wall)){
	while (!place_meeting(x+sign(hsp), y, obj_wall)){
		x += sign(hsp);
	}
	hsp = 0;
}



show_debug_message("attackcounter: " + string(attackcounter / room_speed))
show_debug_message("walljump counter: " + string(walljumpcounter));

if (stunned) {
	hsp = 0;	
}

x += hsp;
y += vsp;
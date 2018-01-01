/// @description Player movement and animation.

// get input

//FIXME: !!!!!! SHOULD BE USED FOR DEBUGGING ONLY !!!!!
if (gamepad_button_check(0, gp_select)) game_end(); // end the game on 'back' pressed

// controller
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
if(attack
	&& (attackcounter/room_speed) >= STAGE_2_ATTACK_WINDOW){
	sprite_index = spr_player_sword_attack2;
	attackpress += 1;
}
// end after first part animation
if (attackpress <= 1
	&& (attackcounter/room_speed) >= STAGE_2_LENGTH) { 
	sprite_index = spr_player;
	attacking = false;
	attackcounter = 0;
	attackpress = 0;
}
// end after total animation
if ((attackcounter/room_speed) >= ATTACK_COOLDOWN) { 
	sprite_index = spr_player;
	attacking = false;
	attackcounter = 0;
	attackpress = 0;
}




// add some gravity
if (vsp < grav){ // if on the down side of the jump curve
	if (vsp + grav < VSP_CAP) vsp += grav; // normal gravity
} else {
	if (vsp + 1.25 * grav < VSP_CAP) vsp += 1.5 * grav; // heavy gravity
}

// wall collision - vertical
if (place_meeting(x, y + vsp, obj_wall)){
	if (place_meeting(x, y - vsp, obj_wall)){ // prevents corner-bug
		if (attacking){ // preventing strange wall paranormality
			vsp = 0;
		}
	}
	while (!place_meeting(x, y+sign(vsp), obj_wall)){
		y += sign(vsp);
	}
	vsp = 0;
	walljumping = false;
	jumpcounter = 0;
}	
	
// wall collision - horizontal
if (place_meeting(x + hsp, y, obj_wall)){
	while (!place_meeting(x+sign(hsp), y, obj_wall)){
		x += sign(hsp);
	}
	hsp = 0;
	jumpcounter = 0;
}

// double jump
if (jump_release) jumpcounter++;
if (jumpcounter == 1 && jump_down){
	jumpcounter++;
	vsp = -jumpspd;
}

// enable jump
if (!jumping 
	&& ((place_meeting(x, y + 1, obj_wall) && jump)// wall below
	||  (place_meeting(x+1, y, obj_wall) || place_meeting(x-1, y, obj_wall)) && jump && walljumpcounter == 0)) { // wall beside
		vsp = -jumpspd;
		// if walljumping, add some jump 'knock'
		if (!place_meeting(x, y + 1, obj_wall)){ // make sure we're in the air
			jumpcounter = 0; // disable the double jump while wall jumping
			walljumping = true;
			walljumpcounter = WALLJUMP_COOLDOWN;
			if (place_meeting(x-1, y, obj_wall)){ // walljump left side
				hsp = +WALLJUMP_KNOCK; 
				sprite_index = spr_player_walljump; 
				image_xscale = -1;
			}
			if (place_meeting(x+1, y, obj_wall)){ // walljump right side
				hsp = -WALLJUMP_KNOCK;
				sprite_index = spr_player_walljump;
				image_xscale = 1;
			}
		}
}

if (walljumpcounter > 0) walljumpcounter--;

show_debug_message("walljump counter: " + string(walljumpcounter));

x += hsp;
y += vsp;
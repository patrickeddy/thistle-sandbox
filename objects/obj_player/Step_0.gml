/// @description Player movement and animation.

// get input
left = -keyboard_check(ord("A"));
right = keyboard_check(ord("D"));
jump = keyboard_check_pressed(vk_space);
jump_down = keyboard_check(vk_space);
jump_release = keyboard_check_released(vk_space);

// figure out the movement direction
if (left + right == 0) { // if we're not actively moving horizontally, and we're not walljumping
	sprite_index = spr_player;
	if (!walljumping){
		hsp = 0;
		if (place_meeting(x, y+1, obj_wall)) hsp = hsp * GROUND_FRICTION; // if on the ground and not actively moving sideways, add a skid
	}
} else {
	walljumping = false; // cancel walljumping
	if (abs(hsp) < HSP_CAP * .2){ // if 20% of the cap
		 hsp += (left + right) * spd * AIR_FRICTION; // move sideways with some friction
	} else {
		hsp = (left + right) * spd; // move normal speed
	}
	sprite_index = spr_player_running;
	if (hsp > 0) image_xscale = 1;
	if (hsp < 0) image_xscale = -1;
}

// variable jump
if (jump) jumpcounter = 0;
if (jump_down) jumpcounter++;
if (jump_release) {
	if (jumpcounter / room_speed >= 1) vsp *= 2.0; // jump a bit higher
}
show_debug_message("counter:" + string(jumpcounter));


if (jumping
	&& !jump_release) {
	jumpcounter++;
} else {
	jumpcounter = 0;
	jumping = false;
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
		// corner-bug stub
	} else {
		while (!place_meeting(x, y+sign(vsp), obj_wall)){
		y += sign(vsp);
		}
		vsp = 0;
		walljumping = false;
	}
}	
	
// wall collision - horizontal
if (place_meeting(x + hsp, y, obj_wall)){
	if (place_meeting(x - hsp, y, obj_wall)){ // prevents corner-bug
		// corner-bug stub
	} else {
		while (!place_meeting(x+sign(hsp), y, obj_wall)){
		x += sign(hsp);
		}
		hsp = 0;
	}
}

// enable jump
if (!jumping 
	&& ((place_meeting(x, y + 1, obj_wall) && jump)// wall below
	||  (place_meeting(x+1, y, obj_wall) || place_meeting(x-1, y, obj_wall)) && jump && walljumpcounter == 0)) { // wall beside
		vsp = -jumpspd;
		jumping = true;
		// if walljumping, add some jump 'knock'
		if (!place_meeting(x, y + 1, obj_wall)){ // make sure we're in the air
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
/// @description Player movement and animation.

// get input
left = -keyboard_check(ord("A"));
right = keyboard_check(ord("D"));
jump = keyboard_check_pressed(vk_space);
jump_down = keyboard_check(vk_space);
jump_release = keyboard_check_released(vk_space);

// figure out the movement direction
if (left + right == 0) {
	hsp -= sign(hsp) * AIR_FRICTION; // if not doing anything at all, just subtract air frictino from the current hsp
	if (place_meeting(x, y+1, obj_wall)) hsp = (hsp - (hsp * AIR_FRICTION)); // if on the ground and not actively moving sideways, add a skid
} else {
	if (abs(hsp) < HSP_CAP * .2){ // if 20% of the cap
		 hsp += (left + right) * spd * AIR_FRICTION; // move sideways with some friction
	} else {
		hsp = (left + right) * spd;
	}
}

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

// Variable jump
if (jump 
	&& jumpcounter > 60
	&& vsp < VSP_CAP){
	vsp *= 1.1;	// make jump a little higher
}

// add some gravity
if (vsp < VSP_CAP){
	if (vsp < -grav){ // if on the up side of the jump curve
		vsp += grav; // normal gravity
	} else {
		vsp += 1.6 * grav; // heavy gravity
	}
}

// enable jump
if (!jumping 
	&& ((place_meeting(x, y + 1, obj_wall) && jump)// wall below
	||  (place_meeting(x+1, y, obj_wall) || place_meeting(x-1, y, obj_wall)) && jump)) { // wall beside
	vsp = -jumpspd;
	jumping = true;
	// if walljumping, add some jump 'knock'
	if (!place_meeting(x, y + 1, obj_wall)){ // make sure we're in the air
		if (place_meeting(x-1, y, obj_wall)) hsp = +WALLJUMP_KNOCK;
		if (place_meeting(x+1, y, obj_wall)) hsp = -WALLJUMP_KNOCK;
	}
}

// wall collision - vertical
if (place_meeting(x, y + vsp, obj_wall)){
	while (!place_meeting(x, y+sign(vsp), obj_wall)){
		y += sign(vsp);
	}
	vsp = 0;
}	
	
// wall collision - horizontal
if (place_meeting(x + hsp, y, obj_wall)){
	while (!place_meeting(x+sign(hsp), y, obj_wall)){
		x += sign(hsp);
	}
	hsp = 0;
}

x += hsp;
y += vsp;
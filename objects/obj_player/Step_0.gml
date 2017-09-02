/// @description Player movement and animation.

// get input
left = -keyboard_check(ord("A"));
right = keyboard_check(ord("D"));
jump = keyboard_check_pressed(vk_space);

// figure out the movement direction
if (left + right == 0) {
	hsp = (hsp - (hsp * AIR_FRICTION)); // if not actively moving sideways, add a skid
} else {
	hsp = (left + right) * spd; // move sideways
}
		

// add some gravity
if (vsp < VSP_CAP){
	vsp += grav;
}

// enable jump
if ((place_meeting(x, y + 1, obj_wall) && jump)// wall below
	|| (place_meeting(x+1, y, obj_wall) || place_meeting(x-1, y, obj_wall)) && jump) { // wall beside
	vsp = -jumpspd;
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
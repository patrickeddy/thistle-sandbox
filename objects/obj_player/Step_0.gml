/// @description Player movement and animation.

// get input
left = -keyboard_check(ord("A"));
right = keyboard_check(ord("D"));
jump = keyboard_check_pressed(vk_space);

// figure out the movement direction
hsp = (left + right) * spd;

// add some gravity
if (vsp < VSP_CAP){
	vsp += grav;
}

// enable jump
if (place_meeting(x, y + 1, obj_wall)
	&& jump) {
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
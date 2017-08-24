/// @description Player movement and animation.

// get input
left = -keyboard_check(ord("A"))
right = keyboard_check(ord("D"))
jump = keyboard_check_pressed(vk_space)

// figure out the movement direction
hsp = (left + right) * spd

if (vsp < VSP_CAP){
	vsp += grav
}

// Hit a wall
if (place_meeting(x, y + vsp, obj_wall)){
	if (jump) vsp = -jumpspd
	else if (sign(vsp) > 0) vsp = 0
}

if (place_meeting(x + hsp, y, obj_wall)){
	while (!place_meeting(x+sign(hsp), y, obj_wall)){
		y += sign(hsp)
	}
	hsp = 0
}



// change player position
x += hsp
y += vsp
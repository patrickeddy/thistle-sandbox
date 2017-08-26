/// @description Player movement and animation.

// get input
left = -keyboard_check(ord("A"))
right = keyboard_check(ord("D"))
jump = keyboard_check_pressed(vk_space)

// figure out the movement direction
hsp = (left + right) * spd

// add some gravity
if (vsp < VSP_CAP
	&& !place_meeting(x, y+1, obj_wall)){
	vsp += grav
}

// enable jump
if (place_meeting(x, y + 1, obj_wall)
	&& jump) {
	vsp = -jumpspd
}


// change player position
if (!place_meeting(x + hsp, y, obj_wall)) x += hsp
if (!place_meeting(x, y + vsp, obj_wall)) y += vsp
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

// We've not hit a wall yet
if (place_meeting(x, y+ vsp, obj_wall)){
	if (jump) vsp = -jumpspd
	else vsp = 0
}



// change player position
x += hsp
y += vsp
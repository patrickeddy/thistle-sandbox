/// @description Player movement and animation.

// get input
left = -keyboard_check(ord("A"))
right = keyboard_check(ord("D"))
up = -keyboard_check(ord("W"))
down = keyboard_check(ord("S"))

// figure out the movement direction
spd = 50;
hsp = left + right
vsp = up + down

// if moving diagonally, reduce that speed
if (hsp != 0 && vsp != 0) {
	hsp = hsp*.7
	vsp = vsp*.7
}

// change player position
x += hsp * spd
y += vsp * spd 
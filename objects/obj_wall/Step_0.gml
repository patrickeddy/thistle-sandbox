/// @description Wall step event.

with (obj_player) {
	if (place_meeting(x, y + vsp, other)){
		while (!place_meeting(x, y+sign(vsp), other)){
			y += sign(vsp)
		}
		vsp = 0
	}
	
	if (place_meeting(x + hsp, y, other)){
		while (!place_meeting(x+sign(hsp), y, other)){
			x += sign(hsp)
		}
		hsp = 0
	}
}
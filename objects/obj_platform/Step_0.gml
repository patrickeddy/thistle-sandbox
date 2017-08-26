/// @description Platform step event

with (obj_player) {
	if (place_meeting(x, y + vsp, other)) {
		if (vsp > 0) {
			while (!place_meeting(x, y+sign(vsp), other)){
				y += sign(vsp)
			}
			vsp = 0
		}	
	}
}
/// @description Spider logic

width = sprite_get_width(mask_index) * image_xscale;
height = sprite_get_height(mask_index) * image_yscale;


// !place_meeting(x+hspd, y+(sprite_height/2)+1, obj_wall)
if (place_meeting(x+hsp, y, obj_wall)){
	hsp = -hsp;
	image_xscale = -image_xscale;
}

// player collision
if (object_exists(obj_player)){
	if (place_meeting(x, y, obj_player)){
		if (obj_player.attacking) { // attacking
			var pd = obj_player.image_xscale; // player facing direction
			x += pd * 15;
			y += -5;
			if (damagecount == 0){
				damagecount += 1;	
				hp -= obj_player.atk;
				image_blend = c_red;
			}
			if (obj_player.attackpress > 1){
				damagecount += 1;
				hp -= obj_player.atk;
				image_blend = c_blue;
			}	
		} else { // not attacking
			damage_player()
		}
	} else {
		damagecount = 0;	
		image_blend = -1;
	}
	if (hp <= 0) {
		drop_item(x, y, obj_heart_piece, 25);
		drop_item(x, y, obj_boot, 5);
		instance_destroy();
	}
}

if (!place_meeting(x, y+vsp+1, obj_wall)){
	vsp += grav;
} else {
	vsp = 0;	
}

// move the spider
x += hsp;
y += vsp;
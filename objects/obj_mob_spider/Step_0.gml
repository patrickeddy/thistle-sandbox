/// @description Spider logic

width = sprite_get_width(mask_index) * image_xscale;
height = sprite_get_height(mask_index) * image_yscale;


// !place_meeting(x+hspd, y+(sprite_height/2)+1, obj_wall)
if (place_meeting(x+hspd, y, obj_wall)){
	hspd = -hspd
	image_xscale = -image_xscale;
}

// player collision
if (object_exists(obj_player)){
	if (place_meeting(x, y, obj_player)
		&& obj_player.attacking){
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

if (!place_meeting(x, y+vspd+1, obj_wall)){
	vspd += grav;
} else {
	vspd = 0;	
}

// move the spider
x += hspd;
y += vspd;
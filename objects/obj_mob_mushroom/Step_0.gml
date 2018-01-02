/// @description Fire when player is within range
// You can write your code in this editor

var distance = distance_to_object(obj_player);

if (!can_fire) {
	fire_countdown--;
	if (fire_countdown == 0) {
		can_fire = true;	
	}
}

// if attack animation is complete, switch to idle
if (image_index > image_number - 1) {
	sprite_index = spr_mob_mushroom;
}

if (can_fire && distance < 200) {
	sprite_index = spr_mob_mushroom_attack;
	fire_projectile_at(obj_player, obj_projectile_spore, x, y);
	can_fire = false;
	fire_countdown = room_speed / (1 / FIRE_COOLDOWN); 
}

// DAMAGE 

if (object_exists(obj_player)){
	if (place_meeting(x, y, obj_player)) {
		if (obj_player.attacking) { 
			hp -= obj_player.atk; 
		} else { 
			damage_player(); 
		}
	}
	if (hp <= 0) {
		drop_item(x, y, obj_heart_piece, 25);
		drop_item(x, y, obj_whetstone, 5);
		instance_destroy();
	}
}
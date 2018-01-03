/// @description Insert description here
// You can write your code in this editor

//player logic (player's hurtbox being hit)
if(place_meeting(x, y, obj_hitbox) && owner == obj_player) {
	// hurt the player
}

// enemy logic (enemy is getting hit by player)
/* 
	this will be changed when player uses hitboxes for attacking, and all
	logic can be tucked into the block above
*/ 
if(place_meeting(x, y, obj_player) && 
   obj_player.attacking && 
   owner != obj_player) {
	is_hit = true;
	damage = obj_player.atk;
}
///draw_hud(health, health_pieces)
// the amount of health of the player
// the amount of health pieces the player has collected

var health_num, hpiece_num;

health_num = argument[0];
hpiece_num = argument[1];

draw_sprite(spr_hud_health, 0, 10, 10);
draw_text(20, 10, string(hpiece_num));
///draw_hud(hp, hpiece_num)
// the amount of health of the player
// the amount of health pieces the player has collected

var health_num, 
	hpiece_num,
	camera_x,
	camera_y;

hp_num = argument[0];
hpiece_num = argument[1];

camera_x = camera_get_view_x(view_camera[0])
camera_y = camera_get_view_y(view_camera[0])

show_debug_message("camera_x: " + string(camera_x));
show_debug_message("camera_y: " + string(camera_y));

draw_sprite(spr_hud_health, 0, 0, 0);
draw_set_font(fnt_hud_health);
draw_text(58, 12, string(hp_num) + "/" + string(max_hp));
draw_sprite(spr_heart_piece, 0, 130, 35);
draw_text(150, 12, string(hpiece_num));
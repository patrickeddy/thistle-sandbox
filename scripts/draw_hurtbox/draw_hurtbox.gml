///draw_hurtbox(width, height, offset_x, offset_y, show)
//width and height in pixels for the hurtbox
//offset_x and offset_y as distance from the origin of the object
//show = true | false, actually display the box

// TODO do offset calculations here with center / top left, etc.
var offset_x = argument[2];
var offset_y = argument[3];

var box = instance_create_depth(x + offset_x, y + offset_y, 5, obj_hurtbox);
box.owner = id;
box.image_xscale = argument[0];
box.image_yscale = argument[1];
box.offset_x = offset_x;
box.offset_y = offset_y;

if (!argument[4]) {
	box.image_alpha = 0;
}

return box;
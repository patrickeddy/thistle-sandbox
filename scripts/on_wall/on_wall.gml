///on_wall(id, x,y)
// id of the object to check
// x coord of the obj
// y coord of the obj
// Returns NONE, LEFT, or RIGHT if meeting a wall

var obj_x, obj_y;

obj_x = argument[0];
obj_y = argument[1];

sdm("on_wall called.");

if (place_meeting(obj_x-1, obj_y, obj_wall)) { sdm("LEFT"); return obj_init.colliding_wall.LEFT; }
else if (place_meeting(obj_x+1, obj_y, obj_wall)) { sdm("RIGHT"); return obj_init.colliding_wall.RIGHT; }
else { sdm("NONE"); return obj_init.colliding_wall.NONE;  }
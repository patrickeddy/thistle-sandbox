///on_ground(obj_index, x, y)
// obj_index index of the object to check
// x coord of the obj
// y coord of the obj
// checks to see if the given x and y are standing on a wall or not

var obj_x, obj_y;

obj_x = argument[0];
obj_y = argument[1];

return place_meeting(obj_x, obj_y + 1, obj_wall);


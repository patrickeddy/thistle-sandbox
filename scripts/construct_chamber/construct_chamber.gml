/// construct_chamber(pos_x, pos_y, chamber)
// chamber is a ds_map object for a single chamber
// (pos_x, pos_y) is origin (top left) of a chamber

var pos_x = argument[0];
var pos_y = argument[1];
var chamber = argument[2];

var next_coordinate_x = pos_x;
var next_coordinate_y = pos_y;
var one_dim_index = 0;

// a string with the name of the chamber (not anything important)
var chamber_name = ds_map_find_value(chamber, "name");
// a ds_list with int values [x, y]
var chamber_size = ds_map_find_value(chamber, "size");
// a ds_map with layer names as keys
var chamber_layers = ds_map_find_value(chamber, "layers");
// a ds_list with strings for obj references
var chamber_fg = ds_map_find_value(chamber_layers, "fg");
var chamber_x = ds_list_find_value(chamber_size, 0);
var chamber_y = ds_list_find_value(chamber_size, 1);
for(var j = 0; j < chamber_x; j++) {
	next_coordinate_x = pos_x;
	for(var k = 0; k < chamber_y; k++) {
		var obj_name = ds_list_find_value(chamber_fg, one_dim_index);
		if (obj_name != "none") {
			var object = asset_get_index(obj_name);
			var instance = instance_create_depth(next_coordinate_x, next_coordinate_y, 0, object);
		}
		next_coordinate_x += 64;
		one_dim_index++;
	}
	next_coordinate_y += 64;
}
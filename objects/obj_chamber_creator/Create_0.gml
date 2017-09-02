/// @description Instantiate chambers within this room from text files

var json_in = file_text_open_read("compiled.json");
var json_string = "";
while (!file_text_eof(json_in)) {
    json_string += file_text_read_string(json_in);
    file_text_readln(json_in);
}

file_text_close(json_in);

var json_map = json_decode(json_string);
var total_chambers = ds_list_size(json_map);
for(var i = 0; i < total_chambers; i++) {
	// this is the full json object for a chamber
	var chamber = ds_list_find_value(json_map, i);
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
	var one_dim_index = 0;
	var next_coordinate_x = 0;
	var next_coordinate_y = 0;
	for(var j = 0; j < chamber_x; j++) {
		next_coordinate_x = 0;
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
	show_message("");
}
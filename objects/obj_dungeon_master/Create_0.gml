/// @description Responsible for creating chamber_creator objects.

var TILE_SIZE = 64;

var json_in = file_text_open_read("compiled.json");
var json_string = "";
while (!file_text_eof(json_in)) {
    json_string += file_text_read_string(json_in);
    file_text_readln(json_in);
}
// show_message(json_string);

file_text_close(json_in);

var json_map = json_decode(json_string);

var chamber_list_key = ds_map_find_first(json_map);
var chamber_list = ds_map_find_value(json_map, "chambers");
var total_chambers = ds_list_size(chamber_list);
// show_message(string(total_chambers));

var origin_x = 0;
var origin_y = 0;

for(var i = 0; i < total_chambers; i++) {
	var chamber = ds_list_find_value(chamber_list, i);
	var chamber_size = ds_map_find_value(chamber, "size");
	var chamber_size_x_offset = ds_list_find_value(chamber_size, 0) * TILE_SIZE;
	var chamber_size_y_offset = ds_list_find_value(chamber_size, 1) * TILE_SIZE;
 	construct_chamber(origin_x, origin_y, chamber);
	origin_x += chamber_size_x_offset;
	// origin_y += chamber_size_y_offset;
} 
///drop_item(origin_x, origin_y, item_to_drop, probability)
// origin_x and origin_y are where the object will drop
// item_to_drop is the item that will drop
// probability is self-explanatory number from 1 - 100

var origin_x = argument[0];
var origin_y = argument[1];
var item_to_drop = argument[2];
var probability = argument[3];

var pick = random(100);

if (pick <= probability) {
	instance_create_depth(origin_x, origin_y, 5, item_to_drop);
}
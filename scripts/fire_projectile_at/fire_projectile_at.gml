///fire_projectile_at(object_id, object_id, int, int);
//object to fire a projectile at
//object id of the projectile to use
//origin_x of instance
//origin_y of instance

var target = argument[0];
var projectile_type = argument[1];
var origin_x = argument[2];
var origin_y = argument[3];

var projectile = instance_create_depth(origin_x, origin_y, 10, projectile_type);
// the speed and other variables are inside the projectile object itself, not here.
projectile.direction = point_direction(projectile.x, projectile.y, target.x, target.y);
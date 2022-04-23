extends TileMap

func on_rigidbody2D_placed(obj:RigidBody2D):
	var radius_squared = pow(obj.collision_shape.shape.radius, 2)
	var area_position = obj.position
	var tiles_colliding = []
	for tile in get_used_cells():
		if map_to_world(tile).distance_squared_to(area_position) <= radius_squared:
			tiles_colliding.append(tile)

	print(tiles_colliding)

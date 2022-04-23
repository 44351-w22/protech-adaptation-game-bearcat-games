extends RigidBody2D

func _ready():
	randomize()
	var x_range = Vector2(100, 400)
	var y_range = Vector2(100, 400)
	var random_x = randi() % int(x_range[1]- x_range[0]) + 1 + x_range[0] 
	var random_y =  randi() % int(y_range[1]-y_range[0]) + 1 + y_range[0]
	var random_pos = Vector2(random_x, random_y)
	
	position=random_pos

extends Area2D
#https://docs.godotengine.org/en/3.1/tutorials/2d/2d_movement.html?highlight=click%20and%20move#click-and-move
export var speed = 100

var target = Vector2()
var velocity = Vector2()
var already_touched = false


func _on_Flower_body_entered(body):
	if !already_touched:
		body.score += 1
		body.turn_pickup += 1
		visible = false
		already_touched = true


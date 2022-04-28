extends Node2D


onready var nav2d = $Navigation2D
onready var character = $Character

func _unhandled_input(event):
	if not event is InputEventMouseButton:
		return
	if event.button_index != BUTTON_LEFT or not event.pressed:
		return
	character.path = nav2d.get_simple_path(character.position, event.global_position)

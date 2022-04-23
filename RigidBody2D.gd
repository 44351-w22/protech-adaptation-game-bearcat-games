extends RigidBody2D

signal placed(object)

onready var collision_shape = $CollisionShape2D

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_accept"):
		emit_signal("placed", self)

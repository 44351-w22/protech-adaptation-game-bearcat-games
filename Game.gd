extends Node2D

func _ready() -> void:
	$RigidBody2D.connect("placed", $TileMap, "on_area2D_placed")
	

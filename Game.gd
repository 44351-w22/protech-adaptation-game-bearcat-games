extends Node2D

onready var nav2d = $Navigation2D
onready var character = $Character

var max_flowers = 3
var current_flower_num = 0
var randomNumGen = RandomNumberGenerator.new()
var max_horizontal_tile = 13
var min_horizontal_tile = 3
var max_vertical_tile = 11
var min_vertical_tile = 3

var player_turn = 1

onready var players = [$Character, $Character2]
var flowers = [$Flowers/RigidBody2D, $Flowers/RigidBody2D2, $Flowers/RigidBody2D3]


func _ready():
	randomNumGen.seed = hash(OS.get_time())
	players[0].is_player_turn = true
	spawn_flowers()

func change_players():
	if(players[0].is_player_turn == true):
		player_turn = 2
		players[0].is_player_turn = false
		players[0].dice_roll_button.visible = false
		players[0].player_score_hud.visible = false
		players[0].player_rolled = false
		players[1].is_player_turn = true
		players[0].my_collision = false
		players[1].dice_roll_button.visible = true
		players[1].player_score_hud.visible = true
		players[1].my_collision = true
		players[0].path = nav2d.get_simple_path(players[0].position, players[0].position)
	elif(players[1].is_player_turn == true):
		player_turn = 1
		players[1].is_player_turn = false
		players[1].dice_roll_button.visible = false
		players[1].player_score_hud.visible = false
		players[1].player_rolled = false
		players[0].is_player_turn = true
		players[0].my_collision = true
		players[1].my_collision = false
		players[0].dice_roll_button.visible = true
		players[0].player_score_hud.visible = true
		players[1].path = nav2d.get_simple_path(players[1].position, players[1].position)
	spawn_flowers()

func spawn_flowers():
	var spawnH = randomNumGen.randi_range(min_horizontal_tile, max_horizontal_tile)
	var spawnV = randomNumGen.randi_range(min_vertical_tile, max_vertical_tile)
	if spawnH % 2 == 0:
		spawnV = spawnV + 0.5
	$Flowers/RigidBody2D.position = Vector2(spawnH * 64, spawnV * 48)
	$Flowers/RigidBody2D.already_touched = false
	$Flowers/RigidBody2D.visible = true
	spawnH = randomNumGen.randi_range(min_horizontal_tile, max_horizontal_tile)
	spawnV = randomNumGen.randi_range(min_vertical_tile, max_vertical_tile)
	if spawnH % 2 == 0:
		spawnV = spawnV + 0.5
	$Flowers/RigidBody2D2.position = Vector2(spawnH * 64, spawnV * 48)
	$Flowers/RigidBody2D2.already_touched = false
	$Flowers/RigidBody2D2.visible = true
	spawnH = randomNumGen.randi_range(min_horizontal_tile, max_horizontal_tile)
	spawnV = randomNumGen.randi_range(min_vertical_tile, max_vertical_tile)
	if spawnH % 2 == 0:
		spawnV = spawnV + 0.5
	$Flowers/RigidBody2D3.position = Vector2(spawnH * 64, spawnV * 48)
	$Flowers/RigidBody2D3.already_touched = false
	$Flowers/RigidBody2D3.visible = true

func _unhandled_input(event):
	if players[0].dice_roll_button.visible == true or players[1].dice_roll_button.visible == true:
		return
	elif players[0].dice_roll_button.visible == false and players[1].dice_roll_button.visible == false:
		if not event is InputEventMouseButton:
			return
		if event.button_index != BUTTON_LEFT or not event.pressed:
			return
		if player_turn == 1:
			players[0].path = nav2d.get_simple_path(players[0].position, event.global_position)
		elif player_turn == 2:
			players[1].path = nav2d.get_simple_path(players[1].position, event.global_position)


func _on_Character_end_turn():
	print("Hello")
	change_players()


func _on_Character2_end_turn():
	print("Hello")
	change_players()

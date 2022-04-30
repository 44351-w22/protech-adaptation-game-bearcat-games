extends KinematicBody2D

const speed = 400
var path setget set_path

var diceRoll = 0
var max_points = 0
var maxDice = 3
var die = RandomNumberGenerator.new()
var score = 0
onready var random_seed = hash(OS.get_time())

var turn_pickup = 0

var valid_tile = false
var player_rolled = false
var is_player_turn = false

onready var my_collision = $CollisionShape2D
signal end_turn

onready var movement_text = $DiceText/MovementNumber
onready var dice_roll_button = $DiceText/DiceRoll
onready var player_score_hud = $DiceText/PlayerScore
onready var player_score_text = $DiceText/PlayerScore/PlayerScoreText

func on_player_turn():
	diceRoll.visible = true

func change_turn():
	if turn_pickup >= max_points and is_player_turn:
		emit_signal("end_turn")
		is_player_turn = false
		turn_pickup = 0
		print("turn change")

func _ready():
	set_process(false)
	die.seed = random_seed
	

func set_path(value:PoolVector2Array):
	path = value
	if value.size() == 0:
		return
	set_process(true)

func _process(delta):
	move_along_path(speed * delta)
	_update_score()
	change_turn()

func move_along_path(distance):
	if is_player_turn:
		var start = position
		while distance > 0 and path.size() > 0:
			var dist_to_next = start.distance_to(path[0])
			if distance <= dist_to_next:
				position = start.linear_interpolate(path[0], distance / dist_to_next)
				return
			elif distance < 0.0:
				position = path[0]
				set_process(false)
				return
			distance -= dist_to_next
			start = path[0]
			path.remove(0)
		set_process(false)

func _on_Button_pressed():
	player_rolled = true
	diceRoll = die.randi_range(1, maxDice)
	max_points = diceRoll
	print(diceRoll)
	$DiceText/PlayerScore/CurrentFlowerRoll.text = "You can pick up " + str(diceRoll) + " flowers this turn."
	dice_roll_button.visible = false
	
func _update_score():
	player_score_text.text = "Current Player Score: " + str(score)

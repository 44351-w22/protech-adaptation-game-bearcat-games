extends Area2D
signal get #gonna use when we find a flower
export var speed = 200

var screen_size
#^^so our lil doods can't run off the screen

func _ready():
	screen_size = get_viewport_rect().size
	hide() # <-- don't want our lil guy hangin out b4 u push start
	

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

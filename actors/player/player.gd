extends CharacterBody2D

@export var speed: float = 250.0

func _physics_process(_delta):
	var input_dir := Vector2.ZERO

	# Read input
	input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	# Movement
	if input_dir.length() > 0:
		input_dir = input_dir.normalized()
		velocity = input_dir * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	# Rotate car to face movement direction
	if velocity.length() > 0:
		rotation = velocity.angle() + PI / 2

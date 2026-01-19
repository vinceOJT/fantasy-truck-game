class_name Player
extends CharacterBody2D

@export var speed: float = 250.0

var current_quest: Quest
var is_quest_completed = false

func _ready() -> void:
	current_quest = preload("uid://c1k3rjn6sjhj3")
	print("Current Quest: " + current_quest.name)

@export var max_speed := 200.0 #400 is tokyo drift 
@export var acceleration := 900.0
@export var friction := 800.0
@export var turn_speed := 2.0
@export var reverse_speed := 100.0

func _physics_process(delta):
	var throttle := Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	var steering := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	# Rotate only if moving
	if velocity.length() > 5:
		rotation += steering * turn_speed * delta

	var forward := Vector2.UP.rotated(rotation)

	# Accelerate
	if throttle != 0:
		var target_speed = max_speed if throttle > 0 else reverse_speed
		velocity = velocity.move_toward(
			forward * target_speed * throttle,
			acceleration * delta
		)
	else:
		# Natural slowdown
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	move_and_slide()

func generate_quest(_prev_loc:Location):
	# Generate a random location that is not the previous location
	pass

func on_location_arrived(location: Location):
	# Check if location matches with quest
	if current_quest != null:
		if current_quest.location == location:
			is_quest_completed = true
			print("Quest Completed!")
			current_quest = null
			# Generate new quest here
			generate_quest(location)

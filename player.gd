extends CharacterBody3D

@onready var player = $"player"
@onready var head = $head
@onready var footstep_player = $footstepsound/AudioStreamPlayer3D

var speed = 3.0
const jump_velocity = 3
const walking_speed = 5.0 
const sprinting_speed = 5
const mouse_sens = 0.2

var lerp_speed = 10.0
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_locked = true 

var bobbing_speed = 4.0       # Speed of the bobbing effect
var bobbing_amount = 0.1    # Amplitude of the bobbing effect
var bobbing_time = 0.0        # Time accumulator for the bobbing effect

var walk_step_interval = 0.7 # Time between footstep sounds when walking
var sprint_step_interval = 0.3 # Time between footstep sounds when sprinting
var step_timer = 0.0 # Timer to track time between steps

func _ready():
	$"../audio/letsgetstarted".play()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotation.x += deg_to_rad(-event.relative.y * mouse_sens)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-45), deg_to_rad(45))
	if event is InputEventKey:
		if event is InputEventKey:
			if event.pressed and event.keycode == KEY_ESCAPE:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				get_tree().change_scene_to_file("res://control.tscn")
func _physics_process(delta: float) -> void:
	var current_step_interval = walk_step_interval

	if Input.is_action_pressed("sprint"):
		speed = sprinting_speed
		current_step_interval = sprint_step_interval
	else: 
		speed = walking_speed

	# Handle gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed

		step_timer -= delta
		if step_timer <= 0.0:
			footstep_player.play()
			step_timer = current_step_interval # Reset the timer based on the current speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

		footstep_player.stop()

	move_and_slide()

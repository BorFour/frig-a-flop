extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 10
const ROTATE_VELOCITY = 20
var ticks_pressed = 0
var charge_jump_counter: float = 0

@onready var collision_shape = $"./CollisionShape3D"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
 

func _physics_process(delta):
	# Add the gravity
	if not is_on_floor():
		velocity.y -= gravity * delta 

	# Handle jump
	if Input.is_action_just_released("ui_accept") and is_on_floor():
		print("Jump! with %.2f" % charge_jump_counter)
		velocity.y = JUMP_VELOCITY * charge_jump_counter

	# Handle charge jump
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		charge_jump_counter += delta
	else:
		charge_jump_counter = 0

	# Handle rotation
	var jump_rotation = -delta * ROTATE_VELOCITY / 10

	if is_on_floor_only():
		ticks_pressed = 0
	elif Input.is_action_pressed("ui_up"):
		ticks_pressed += 1
		jump_rotation *= 3
	elif Input.is_action_pressed("ui_down"):
		ticks_pressed = max(0, ticks_pressed - 3)
	else:
		ticks_pressed = max(0, ticks_pressed - 1)
	
	if not is_on_floor():
		rotate_x(jump_rotation - ticks_pressed * 0.003)
	elif is_on_floor_only():
		ticks_pressed = 0
		#rotation.x = 0
		#position = Vector3(0, 0, 0)
		rotate_toward(0, 0, 0)

	move_and_slide()

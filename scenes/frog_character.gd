extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 10
const ROTATE_VELOCITY = 20
var jump_force: float = 0
var spin_velocity: float = 0

@onready var collision_shape = $"./CollisionShape3D"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
 

func _physics_process(delta):
	# Add the gravity
	if not is_on_floor():
		velocity.y -= gravity * delta 

	# Handle jump
	if Input.is_action_just_released("jump") and is_on_floor():
		print("Jump! with %.2f" % jump_force)
		velocity.y = JUMP_VELOCITY * jump_force

	# Handle charge jump
	if Input.is_action_pressed("jump") and is_on_floor():
		jump_force += delta
	else:
		jump_force = 0

	# Handle rotation
	var jump_rotation = -delta * ROTATE_VELOCITY / 10

	if is_on_floor_only():
		spin_velocity = 0
	elif Input.is_action_pressed("front_spin"):
		spin_velocity += 1
		jump_rotation *= 3
	elif Input.is_action_pressed("back_spin"):
		spin_velocity = max(0, spin_velocity - 3)
	else:
		spin_velocity = max(0, spin_velocity - 1)
	
	if not is_on_floor():
		rotate_x(jump_rotation - spin_velocity * 0.003)
	elif is_on_floor_only():
		spin_velocity = 0
		#rotation.x = 0
		#position = Vector3(0, 0, 0)
		rotate_toward(0, 0, 0)

	move_and_slide()

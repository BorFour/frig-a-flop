extends CharacterBody3D


const SPEED: float = 5.0
const JUMP_VELOCITY: float = 10
const ROTATE_VELOCITY: float = 20
const MIN_JUMP_FORCE: float = 0.5
const MIN_STANDING_X_ROTATION_OFFSET: float = 0.02
const BASE_BACK_TO_STANDING_SPIN_VELOCITY: float = 100
const MAX_JUMP_FORCE: float = 10
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
		if jump_force < MIN_JUMP_FORCE:
			print("Not enough jump force %.2f" % jump_force)
			jump_force = 0
		else:
			print("Jump! with %.2f" % jump_force)
			velocity.y = JUMP_VELOCITY * jump_force

	# Handle charge jump
	if Input.is_action_pressed("jump") and is_on_floor():
		jump_force += delta * 2
		jump_force = min(jump_force, MAX_JUMP_FORCE)
	else:
		jump_force = 0

	# Handle rotation
	var base_rotation = -delta * ROTATE_VELOCITY / 10

	if is_on_floor_only():
		base_rotation = 0
		if abs(rotation.x) > MIN_STANDING_X_ROTATION_OFFSET:
			spin_velocity = (
				BASE_BACK_TO_STANDING_SPIN_VELOCITY * min(0.15, abs(rotation.x))
				 if rotation.x > 0
				else -BASE_BACK_TO_STANDING_SPIN_VELOCITY * min(0.15, abs(rotation.x))
			)
		else:
			spin_velocity = 0
	elif Input.is_action_pressed("front_spin"):
		spin_velocity += 1
		base_rotation *= 3
	elif Input.is_action_pressed("back_spin"):
		spin_velocity = max(0, spin_velocity - 3)
	else:
		spin_velocity = max(0, spin_velocity - 1)
	
	rotate_x(base_rotation - spin_velocity * 0.003)
	move_and_slide()

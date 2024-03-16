extends Camera3D

@onready var target: Node3D = $"../FrogCharacter"
@onready var initial_target_position: Vector3 = target.position
@onready var initial_camera_position: Vector3 = position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not target:
		print("Need a target to look at")
		return

	position.z = initial_camera_position.z + abs(target.position.y - initial_target_position.y)
	look_at(target.position)

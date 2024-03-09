extends Camera3D

@onready var target: Node3D = $"../FrogCharacter"

# Called when the node enters the scene tree for the first time.
func _ready():
	print(target)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target:
		look_at(target.position)
	

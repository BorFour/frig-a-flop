extends MeshInstance2D


@onready var target: Node3D = $"../../FrogCharacter"
 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mesh.text = "%.2f" % target.get(get_meta("target_attribute")) if target != null else ""

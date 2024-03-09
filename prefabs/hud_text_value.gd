extends Label


@onready var target: Node3D = $"/root/MainScene/FrogCharacter"
 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target_value = target.get(get_meta("target_attribute"))
	
	if target_value != null:
		self.text = "%s: %.2f" % [get_meta("target_attribute"), target_value]

extends Label


@export var target: Node3D
 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var target_attribute: String = get_meta("target_attribute")
	var cast_to_int = get_meta("cast_to_int")
	var target_value = target.get(target_attribute)
	
	if target_value == null:
		return

	self.text = (
		"%s: %d" % [target_attribute, int(target_value)]
		if cast_to_int
		else "%s: %.2f" % [target_attribute, target_value]
	)

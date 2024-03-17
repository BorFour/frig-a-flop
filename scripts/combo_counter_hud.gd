extends Label

var rip_combo_text_tween: Tween
var combo_up_text_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_frog_character_rip_combo(last_combo: int):
	print("Handling RIP combo signal")

	if combo_up_text_tween:
		combo_up_text_tween.kill()
	
	# Color for the fade out
	var new_color: Color = Color.DARK_RED
	var new_color_transparent: Color = new_color
	new_color_transparent.a = 0

	var decrease_combo_text = func(x: int):
		text = "💀 RIP X" + str(x) + " combo 💀"
		
	label_settings.font_color = Color.WHITE

	rip_combo_text_tween = create_tween()
	rip_combo_text_tween.set_parallel(true)
	
	rip_combo_text_tween.tween_property(label_settings, "font_size", 50, 1).set_trans(Tween.TRANS_ELASTIC)
	rip_combo_text_tween.tween_property(label_settings, "font_color", new_color, 2).set_trans(Tween.TRANS_CUBIC)
	rip_combo_text_tween.tween_method(decrease_combo_text, last_combo, 0, 3).set_trans(Tween.TRANS_EXPO)
	rip_combo_text_tween.tween_property(label_settings, "font_color", new_color_transparent, max(1, last_combo / 10)).set_delay(2)
 
func _on_frog_character_combo_up(new_combo: int):
	print("Handling combo up signal")
	
	if rip_combo_text_tween and rip_combo_text_tween.is_running():
		print("RIP combo is playing")
		return
	
	if combo_up_text_tween and combo_up_text_tween.is_running():
		print("Previous combo up tween is running")
		combo_up_text_tween.kill()

	combo_up_text_tween = create_tween()
	#label_settings.font_size = 0
	
	# Color for the fade out
	var new_color: Color = Color.WHITE
	var new_color_transparent: Color = new_color
	new_color_transparent.a = 0
	
	label_settings.font_color = Color.WHITE
	text = "X%d" % new_combo

	combo_up_text_tween.set_parallel(true)
	#combo_up_text_tween.tween_property(label_settings, "font_color", new_color, 1)
	combo_up_text_tween.tween_property(label_settings, "font_size", 50, 1).set_trans(Tween.TRANS_ELASTIC)
	combo_up_text_tween.tween_property(label_settings, "font_color", new_color_transparent, 2).set_delay(1).set_trans(Tween.TRANS_CUBIC)


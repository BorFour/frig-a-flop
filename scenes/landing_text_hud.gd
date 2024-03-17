extends Label


func _on_frog_character_frog_landed(angle):
	var new_text: String
	var new_color: Color

	if angle <= 0.1:
		new_text = "Perfect!!!"
		new_color = Color.GREEN
	elif angle <= 0.25:
		new_text = "Noice!!"
		new_color = Color.GREEN_YELLOW
	elif angle <= 0.6:
		new_text = "Good!"
		new_color = Color.DODGER_BLUE
	elif angle <= 1.4:
		new_text = "Meh"
		new_color = Color.WHITE_SMOKE
	else:
		new_text = "Fail"
		new_color = Color.DARK_RED

	text = new_text
	label_settings.font_color = Color.WHITE
	label_settings.font_size = 1
	var fade_text_tween: Tween = create_tween()
	
	# Color for the fade out
	var new_color_transparent: Color = new_color
	new_color_transparent.a = 0

	fade_text_tween.set_parallel(true)
	fade_text_tween.tween_property(label_settings, "font_color", new_color, 1)
	fade_text_tween.tween_property(label_settings, "font_size", 50, 1).set_trans(Tween.TRANS_ELASTIC)
	fade_text_tween.tween_property(label_settings, "font_color", new_color_transparent, 2).set_delay(1).set_trans(Tween.TRANS_CUBIC)

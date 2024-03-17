extends Label


func _on_frog_character_frog_landed(
	landing_quality: Commons.LandingQuality,
	landing_angle: float,
	score_increment: int
):
	var new_text: String
	var new_color: Color

	match landing_quality:
		Commons.LandingQuality.PERFECT:
			new_text = "Perfect!!!"
			new_color = Color.GREEN
		Commons.LandingQuality.NOICE:
			new_text = "Noice!!"
			new_color = Color.GREEN_YELLOW
		Commons.LandingQuality.GOOD:
			new_text = "Good!"
			new_color = Color.DODGER_BLUE
		Commons.LandingQuality.MEH:
			new_text = "Meh"
			new_color = Color.WHITE_SMOKE
		Commons.LandingQuality.FAIL:
			new_text = "Fail"
			new_color = Color.DARK_RED
		_:
			print("Unknown landing quality!!!!!")
			
	new_text += "\n+ %d pts" % score_increment

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

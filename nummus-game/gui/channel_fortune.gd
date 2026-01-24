extends Button

func _on_channel_fortune_pressed() -> void:
	if !Globals.fortune_channeled:
		Globals.fortune_channeled = true
	else:
		Globals.fortune_channeled = false

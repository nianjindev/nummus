extends Button

func calculate_channeled_fortune():
	if Globals.fortune >= 20:
		Globals.fortune_channeled_amount = .5
	elif Globals.fortune >= 12:
		Globals.fortune_channeled_amount = .3
	elif Globals.fortune >= 8:
		Globals.fortune_channeled_amount = .2
	elif Globals.fortune >= 4:
		Globals.fortune_channeled_amount = .1

func reset_channeled_fortune():
	Globals.fortune_channeled_amount = 0

func _on_channel_fortune_pressed() -> void:
	if !Globals.fortune_channeled:
		Globals.fortune_channeled = true
		calculate_channeled_fortune()
		
	else:
		Globals.fortune_channeled = false
		reset_channeled_fortune()

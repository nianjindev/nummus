extends Button

func _on_skip_pressed() -> void:
	Globals.coin_guess = "skip"
	Signalbus.coin_flipped.emit()


func _on_tails_pressed() -> void:
	Globals.coin_guess = "tails"
	Signalbus.coin_flipped.emit()


func _on_heads_pressed() -> void:
	Globals.coin_guess = "heads"
	Signalbus.coin_flipped.emit()

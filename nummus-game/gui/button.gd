extends Button

func _on_skip_pressed() -> void:
	Signalbus.coin_flipped.emit("skip")


func _on_tails_pressed() -> void:
	Signalbus.coin_flipped.emit("tails")


func _on_heads_pressed() -> void:
	Signalbus.coin_flipped.emit("heads")

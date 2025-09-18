extends Button


func _on_pressed() -> void:
	Signalbus.coin_flipped.emit()
	

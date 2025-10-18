extends TextureButton


func _on_skip_pressed() -> void:
	Signalbus.coin_flipped.emit(Sides.SKIP)

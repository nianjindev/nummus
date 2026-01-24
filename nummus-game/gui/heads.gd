extends TextureButton


func _on_heads_pressed() -> void:
	Signalbus.coin_flipped.emit(Sides.HEADS)
	

#func _on_heads_mouse_entered() -> void:
	#if Globals.fortune_channeled:
		#Globals.head_weight += Globals.fortune_channeled_amount
		#Globals.tail_weight -= Globals.fortune_channeled_amount
		#Signalbus.update_side_percent_ui.emit()
	#else:
		#Signalbus.update_side_percent_ui.emit()
#
#func _on_mouse_exited() -> void:
	#if Globals.fortune_channeled:
		#Globals.head_weight -= Globals.fortune_channeled_amount
		#Globals.tail_weight += Globals.fortune_channeled_amount
		#Signalbus.update_side_percent_ui.emit()
	#else:
		#Signalbus.update_side_percent_ui.emit()

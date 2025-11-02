extends Label

func _ready():
	GuiManager.update_action_text.connect(_on_ui_updated)
	
func _on_ui_updated(action_text: String):
	text = action_text

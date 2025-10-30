extends Label

func _ready():
	GuiManager.update_period_text.connect(_on_ui_updated)
	
func _on_ui_updated(amount: int):
	text = str(amount)

extends Label

func _ready():
	GuiManager.update_enemy_health_text.connect(_on_ui_updated)
	
func _on_ui_updated(amount: int, max_health: int):
	text = str(amount as int)+ "/" + str(max_health)
	

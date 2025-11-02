extends Sprite3D

func _ready():
	GuiManager.toggle_enemy_ui.connect(_on_ui_toggled)
	
func _on_ui_toggled(show: bool):
	visible = show

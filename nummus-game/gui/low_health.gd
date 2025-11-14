extends TextureRect

func _ready():
	GuiManager.toggle_low_health_ui.connect(toggle_ui)
	
func toggle_ui(show: bool):
	self.visible = show

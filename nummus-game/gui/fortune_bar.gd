extends TextureProgressBar

@export var fortune_text: RichTextLabel

func _ready():
	GuiManager.update_fortune_bar_ui.connect(_on_fortune_updated)
	GuiManager.update_fortune_bar_ui.emit()
	
func _on_fortune_updated():
	update_fortune_bar()
	update_fortune_text()
	
func update_fortune_bar():
	value = Globals.fortune
	
func update_fortune_text():
	fortune_text.text = str(Globals.fortune) + "/" + str(Globals.max_fortune)

extends TextureProgressBar

@export var misfortune_text: RichTextLabel

func _ready():
	GuiManager.update_misfortune_bar_ui.connect(_on_misfortune_updated)
	GuiManager.update_misfortune_bar_ui.emit()
	
func _on_misfortune_updated():
	update_misfortune_bar()
	update_misfortune_text()
 
func update_misfortune_bar():
	value = Globals.misfortune
	max_value = Globals.max_misfortune

func update_misfortune_text():
	misfortune_text.text = str(Globals.misfortune) + "/" + str(Globals.max_misfortune)

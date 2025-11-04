extends TextureRect

@onready var shield_text: RichTextLabel = $ShieldText

func _ready():
	GuiManager.update_shield_ui.connect(update_ui)
	GuiManager.toggle_shield_ui.connect(toggle_visibility)
	toggle_visibility(false)

func toggle_visibility(show: bool):
	visible = show
	
func update_ui():
	if Globals.shield <= 0:
		toggle_visibility(false)
	else:
		toggle_visibility(true)
	shield_text.text = str(Globals.shield)

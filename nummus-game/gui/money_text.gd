extends RichTextLabel

func _ready():
	GuiManager.update_money_text.connect(update_ui)
	update_ui()
	
func update_ui():
	text = "$" + str(Globals.money)

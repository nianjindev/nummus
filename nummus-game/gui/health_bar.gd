extends TextureProgressBar

@export var health_text: RichTextLabel

func _ready():
	GuiManager.update_health_ui.connect(_on_health_visuals_updated)
	GuiManager.update_health_ui.emit()

func update_health_text():
	health_text.text = str(Globals.health) + "/" + str(Globals.max_health)

func update_health_bar():
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "value", Globals.health, 0.4)

func _on_health_visuals_updated():
	update_health_bar()
	update_health_text()

extends TextureRect

@onready var shield_text: RichTextLabel = $ShieldText
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var last_shield_amount = 0

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
		
	if Globals.shield > last_shield_amount:
		animation_player.play("gain_shield")
	else:
		animation_player.play("lose_shield")
	
	last_shield_amount = Globals.shield
	shield_text.text = str(Globals.shield)

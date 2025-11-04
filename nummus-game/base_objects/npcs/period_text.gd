extends Label

@onready var enemy_anim: AnimationPlayer = $"../../../../AnimationPlayer"

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	GuiManager.update_period_text.connect(_on_ui_updated)
	
func _on_ui_updated(amount: int):
	text = str(amount)
	if amount == 0:
		
		animation_player.play("period_end")
	else:
		animation_player.play("period_neutral")
		

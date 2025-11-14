extends RichTextLabel

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var misfortune_event_string: RichTextLabel = $MisfortuneEvent

func _ready():
	GuiManager.show_misfortune_inflicted.connect(shown)
	
func shown(effect_string: String):
	print("MISFORTUNE APPEAR")
	misfortune_event_string.text = effect_string
	animation_player.play("appear")
	

func reset_misfortune():
	Globals.reset_misfortune()

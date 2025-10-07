extends Control

@onready var coin_flip_buttons: Control = $CoinFlipButtons


func _ready():
	%LevelCompleted.hide()
	Signalbus.toggle_game_ui.connect(toggle_all)
	Signalbus.toggle_coin_flip_ui.connect(_on_coin_flip_ui_toggled)
	Signalbus.toggle_level_completed_ui.connect(_on_level_completed_toggled)
	


#Toggling UI Visibility
func toggle_all(visible: bool):
	self.visible = visible

func _on_coin_flip_ui_toggled(visible: bool):
	coin_flip_buttons.visible = visible
	
#Coin Flipping Handling
func _on_heads_pressed() -> void:
	Signalbus.coin_flipped.emit(Sides.HEADS)


func _on_tails_pressed() -> void:
	Signalbus.coin_flipped.emit(Sides.TAILS)


func _on_skip_pressed() -> void:
	Signalbus.coin_flipped.emit(Sides.SKIP)

func _on_level_completed_toggled(show: bool) -> void:
	Signalbus.toggle_coin_flip_ui.emit(false)
	%LevelCompleted.visible = show
	
func _on_next_stage_pressed() -> void:
	LevelManager.next_stage()
	toggle_all(false)

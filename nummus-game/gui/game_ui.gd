extends Control

@onready var coin_flip_buttons: Control = $CoinFlipButtons


func _ready():
	toggle_all(false)
	%LevelCompleted.hide()
	Signalbus.toggle_game_ui.connect(toggle_all)
	Signalbus.toggle_coin_flip_ui.connect(_on_coin_flip_ui_toggled)
	Signalbus.toggle_level_completed_ui.connect(_on_level_completed_toggled)
	
	# check if scene has changed
	Signalbus.scene_changed.connect(level_check)
	
func level_check():
	if SceneManager.current_scene.name == "BaseLevel":
		toggle_all(true)
	else:
		toggle_all(false)

#Toggling UI Visibility
func toggle_all(on: bool):
	self.visible = on

func _on_coin_flip_ui_toggled(on: bool):
	coin_flip_buttons.visible = on
	
#Coin Flipping Handling
func _on_heads_pressed() -> void:
	Signalbus.coin_flipped.emit(Sides.HEADS)


func _on_tails_pressed() -> void:
	Signalbus.coin_flipped.emit(Sides.TAILS)


func _on_skip_pressed() -> void:
	Signalbus.coin_flipped.emit(Sides.SKIP)

func _on_level_completed_toggled(on: bool) -> void:
	Signalbus.toggle_coin_flip_ui.emit(false)
	%LevelCompleted.visible = on
	
func _on_next_stage_pressed() -> void:
	LevelManager.next_stage()

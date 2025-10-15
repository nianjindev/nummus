extends Control

@onready var coin_flip_buttons: Control = $CoinFlipButtons
@onready var level_text: RichTextLabel = $LevelSplash/LevelText
@onready var level_splash: ColorRect = $LevelSplash
@onready var splash_fade: AnimationPlayer = $LevelSplash/SplashFade
@onready var heads_percent: RichTextLabel = $CoinFlipButtons/Heads/HeadsPercent
@onready var tails_percent: RichTextLabel = $CoinFlipButtons/Tails/TailsPercent

func _ready():
	level_check()
	%LevelCompleted.hide()
	level_splash.visible = false
	Signalbus.toggle_game_ui.connect(toggle_all)
	Signalbus.toggle_coin_flip_ui.connect(_on_coin_flip_ui_toggled)
	Signalbus.toggle_level_completed_ui.connect(_on_level_completed_toggled)
	Signalbus.update_side_percent_ui.connect(_on_side_percent_updated)
	
	LevelManager.enter_level.connect(commence_level)
	
	# check if scene has changed
	Signalbus.scene_changed.connect(level_check)
	
func level_check():
	if SceneManager.current_scene.name == "BaseLevel":
		toggle_all(true)
	else:
		toggle_all(false)

func commence_level():
	level_text.text = LevelManager.current_level.capitalize() + " - " + str(LevelManager.current_stage)
	level_splash.visible = true
	splash_fade.play("fade_out")
	await splash_fade.animation_finished
	level_splash.visible = false
	
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
	
func _on_side_percent_updated(heads: float, tails: float) -> void:
	heads_percent.text = str(int(round(heads * 100))) + "%"
	tails_percent.text = str(int(round(tails * 100))) + "%"
	

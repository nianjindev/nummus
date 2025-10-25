extends Control

@onready var coin_flip_buttons: Control = $CoinFlipButtons
@onready var level_text: RichTextLabel = $LevelSplash/LevelText
@onready var level_splash: ColorRect = $LevelSplash
@onready var splash_fade: AnimationPlayer = $LevelSplash/SplashFade
@onready var heads_percent: RichTextLabel = $CoinFlipButtons/Heads/HeadsPercent
@onready var tails_percent: RichTextLabel = $CoinFlipButtons/Tails/TailsPercent
@onready var channel_fortune: Button = $ChannelFortune
@export var level_completed: ColorRect

func _ready():
	level_check()
	level_completed.hide()
	level_splash.visible = false
	GuiManager.toggle_game_ui.connect(toggle_all)
	GuiManager.toggle_coin_flip_ui.connect(_coin_flip_ui_toggled)
	GuiManager.toggle_level_completed_ui.connect(_level_completed_toggled)
	 #Signalbus.update_side_percent_ui.connect(_on_side_percent_updated)
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

func _coin_flip_ui_toggled(on: bool):
	coin_flip_buttons.visible = on
	channel_fortune.visible = on

func _level_completed_toggled(on: bool) -> void:
	Signalbus.toggle_coin_flip_ui.emit(false)
	level_completed.visible = on

#func _on_side_percent_updated() -> void:
	#heads_percent.text = str(int(Globals.head_weight * 100)) + "%"
	#tails_percent.text = str(int(Globals.tail_weight * 100)) + "%"

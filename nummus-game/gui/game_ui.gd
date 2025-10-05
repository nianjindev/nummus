extends Control

@onready var fortune_bar: TextureProgressBar = $Bars/FortuneBar
@onready var misfortune_bar: TextureProgressBar = $Bars/MisfortuneBar
@onready var coin_flip_buttons: Control = $CoinFlipButtons
@onready var bars: Control = $Bars




func _ready():
	Signalbus.toggle_game_ui.connect(toggle_all)
	Signalbus.toggle_coin_flip_ui.connect(_on_coin_flip_ui_toggled)
	


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

extends Control

@onready var amount: RichTextLabel = $PlayerInterface/MoneyBackdrop/Amount
@onready var health_bar: TextureProgressBar = $PlayerInterface/HealthBar
@onready var fortune_bar: TextureProgressBar = $PlayerInterface/FortuneBars/FortuneBar
@onready var misfortune_bar: TextureProgressBar = $PlayerInterface/FortuneBars/MisfortuneBar
@onready var fortune_bars: Control = $PlayerInterface/FortuneBars

func _ready():
	Globals.connect("money_changed", Callable(change_money_amount))
	Globals.connect("health_changed", Callable(change_health_amount))
	health_bar.value = Globals.health
	amount.text = "$" + str(Globals.money)
	Signalbus.toggle_bar_ui.connect(_on_bar_ui_toggled)
	Signalbus.update_fortune_bar_ui.connect(_on_fortune_bar_value_changed)
	Signalbus.update_misfortune_bar_ui.connect(_on_misfortune_bar_value_changed)
	
func change_money_amount():
	amount.text = "$" + str(Globals.money)
	
func change_health_amount():
	health_bar.value = Globals.health

func _on_fortune_bar_value_changed():
	fortune_bar.value = Globals.fortune
		
func _on_misfortune_bar_value_changed():
	misfortune_bar.value = Globals.misfortune
	
func _on_bar_ui_toggled(visible: bool):
	fortune_bars.visible = visible
	

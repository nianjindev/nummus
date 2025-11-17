extends Control

@export var fortune_bars: VBoxContainer


func _ready():
	# Globals.money_changed.connect("money_changed", Callable(change_money_amount))
	GuiManager.toggle_bar_ui.connect(_on_bar_ui_toggled)
	GuiManager.toggle_global_ui.connect(_on_ui_toggled)
	update_all()
	

func _on_ui_toggled(show: bool):
	self.visible = show
	
func update_all():
	pass

func _on_bar_ui_toggled(on: bool):
	fortune_bars.visible = on

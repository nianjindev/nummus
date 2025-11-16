extends Control

@export var fortune_bars: VBoxContainer
@export var health_bar: TextureProgressBar 
@export var fortune_bar: TextureProgressBar
@export var misfortune_bar: TextureProgressBar
@export var fortune_text: RichTextLabel
@export var misfortune_text: RichTextLabel
@export var health_text: RichTextLabel

func _ready():
	# Globals.money_changed.connect("money_changed", Callable(change_money_amount))
	GuiManager.toggle_bar_ui.connect(_on_bar_ui_toggled)
	GuiManager.update_fortune_bar_ui.connect(_on_fortune_updated)
	GuiManager.update_misfortune_bar_ui.connect(_on_misfortune_updated)
	GuiManager.update_health_ui.connect(_on_health_visuals_updated)
	GuiManager.toggle_global_ui.connect(_on_ui_toggled)
	update_all()
	

func _on_ui_toggled(show: bool):
	self.visible = show
	
########### TEXT ###########
func update_fortune_text():
	fortune_text.text = str(Globals.fortune) + "/" + str(Globals.max_fortune)
	
func update_misfortune_text():
	misfortune_text.text = str(Globals.misfortune) + "/" + str(Globals.max_misfortune)

func update_health_text():
	health_text.text = str(Globals.health) + "/" + str(Globals.max_health)

########### BARS ###########
func update_fortune_bar():
	fortune_bar.value = Globals.fortune
	
func update_misfortune_bar():
	misfortune_bar.value = Globals.misfortune
	
func update_health_bar():
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(health_bar, "value", Globals.health, 0.4)

########### VISUAL SIGNAL RECEIVERS ###########
func _on_fortune_updated():
	update_fortune_bar()
	update_fortune_text()
		
func _on_misfortune_updated():
	update_misfortune_bar()
	update_misfortune_text()
	
func _on_health_visuals_updated():
	update_health_bar()
	update_health_text()
	
func update_all():
	_on_fortune_updated()
	_on_misfortune_updated()
	_on_health_visuals_updated()

func _on_bar_ui_toggled(on: bool):
	fortune_bars.visible = on

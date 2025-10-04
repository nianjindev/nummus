extends Node

signal coin_flipped(state: String)
signal skill_check_begin(time: float)
signal skill_check_finish(success: bool)


signal current_enemy_defeated()

signal level_loaded

######## Change Values ########
signal change_fortune_and_update_ui(add: bool, amount: int, update_ui: bool)
signal change_misfortune_and_update_ui(add: bool, amount: int, update_ui: bool)
signal change_enemy_health(add: bool, amount: int)

######## UI ########
signal update_fortune_bar_ui() 
signal update_misfortune_bar_ui()
signal toggle_game_ui(show: bool)
signal toggle_coin_flip_ui(show: bool)
signal toggle_bar_ui(show: bool)
 

func _ready():
	skill_check_finish.connect(_on_skill_check)
	current_enemy_defeated.connect(_on_current_enemy_defeated)
	change_fortune_and_update_ui.connect(_on_fortune_changed)
	change_misfortune_and_update_ui.connect(_on_misfortune_changed)

func _on_skill_check(success: bool):
	if success:
		Globals.in_favor = true
	else: 
		Globals.in_favor = false

func _on_current_enemy_defeated():
	Signalbus.toggle_game_ui.emit(false)
	# open win menu

func _on_fortune_changed(add: bool, amount: int, update_ui: bool):
	if Globals.fortune + amount > Globals.max_fortune or Globals.fortune + amount < 0 or amount > Globals.max_fortune:
		Globals.fortune = Globals.fortune
	elif add:
		Globals.fortune += amount
	else:
		Globals.fortune = amount
	
	if update_ui:
		update_fortune_bar_ui.emit()
		
func _on_misfortune_changed(add: bool, amount: int, update_ui: bool):
	if Globals.misfortune + amount > Globals.max_misfortune or Globals.misfortune + amount < 0 or amount > Globals.max_misfortune:
		Globals.misfortune = Globals.max_misfortune
	elif add:
		Globals.misfortune += amount
	else:
		Globals.misfortune = amount
	
	if update_ui:
		update_misfortune_bar_ui.emit()
		
	
	

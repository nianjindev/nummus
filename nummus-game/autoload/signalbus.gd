extends Node
@warning_ignore("unused_signal")
signal coin_flipped(state: String)
@warning_ignore("unused_signal")
signal skill_check_begin(time: float)
signal skill_check_finish(success: bool)

### Scenes
@warning_ignore("unused_signal")
signal scene_changed()

signal current_enemy_defeated()
@warning_ignore("unused_signal")
signal level_loaded

######## Change Values ########
signal change_fortune_and_update_ui(add: bool, amount: int, update_ui: bool)
signal change_misfortune_and_update_ui(add: bool, amount: int, update_ui: bool)
signal change_health_and_update_ui(add: bool, amount: int, update_ui: bool)
@warning_ignore("unused_signal")
signal change_enemy_health(add: bool, amount: int)

######## UI ########
signal update_fortune_bar_ui() 
signal update_misfortune_bar_ui()
signal update_health_bar_ui()
@warning_ignore("unused_signal")
signal toggle_game_ui(show: bool)
@warning_ignore("unused_signal")
signal toggle_coin_flip_ui(show: bool)
@warning_ignore("unused_signal")
signal toggle_bar_ui(show: bool)
signal toggle_level_completed_ui(show: bool)
signal update_side_percent_ui(heads: float, tails: float)

######## VFX ########
signal enemy_hurt_visuals()

func _ready():
	skill_check_finish.connect(_on_skill_check)
	current_enemy_defeated.connect(_on_current_enemy_defeated)
	change_fortune_and_update_ui.connect(_on_fortune_changed)
	change_misfortune_and_update_ui.connect(_on_misfortune_changed)
	change_health_and_update_ui.connect(_on_health_changed)

func _on_skill_check(success: bool):
	if success:
		Globals.in_favor = true
	else: 
		Globals.in_favor = false

func _on_current_enemy_defeated():
	toggle_level_completed_ui.emit(true)

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
		
func _on_health_changed(add: bool, amount: int, update_ui: bool):
	if Globals.health + amount > Globals.max_health or Globals.health + amount < 0 or amount > Globals.max_health:
		Globals.health = Globals.health
	elif add:
		Globals.health += amount
	else:
		Globals.health = amount
	
	if update_ui:
		update_health_bar_ui.emit()
	

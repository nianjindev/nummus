extends Node

signal coin_flipped(state: String)
signal skill_check_begin(time: float)
signal skill_check_finish(success: bool)
signal change_enemy_health(add: bool, amount: int)
signal current_enemy_defeated()
signal toggle_ui(show: bool)
signal level_loaded

func _ready():
	skill_check_finish.connect(_on_skill_check)
	current_enemy_defeated.connect(_on_current_enemy_defeated)

func _on_skill_check(success: bool):
	if success:
		Globals.in_favor = true
	else:
		Globals.in_favor = false

func _on_current_enemy_defeated():
	Signalbus.toggle_ui.emit(false)
	SceneManager.goto_scene("res://stages/shop.tscn")

extends Node

signal coin_flipped(state: String)
signal skill_check_begin(time: float)
signal skill_check_finish(success: bool)
signal change_enemy_health(add: bool, amount: int)
signal change_game_ui_coin_flip_button_visibility(visibility: bool)

func _ready():
	skill_check_finish.connect(_on_skill_check)
	

func _on_skill_check(success: bool):
	if success:
		Globals.in_favor = true
	else:
		Globals.in_favor = false
		
	

extends Node

signal coin_flipped(state: String)
signal skill_check_begin(time: float)
signal skill_check_finish(success: bool)

func _ready():
	skill_check_finish.connect(_on_skill_check)

func _on_skill_check(success: bool):
	if success:
		Globals.in_favor = true
	else:
		Globals.in_favor = false

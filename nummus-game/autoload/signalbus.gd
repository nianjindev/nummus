extends Node
@warning_ignore("unused_signal")
signal coin_flipped(state: String)
# @warning_ignore("unused_signal")
# signal skill_check_begin(time: float)
# signal skill_check_finish(success: bool)

### Scenes
@warning_ignore("unused_signal")
signal scene_changed()
signal current_enemy_defeated()
@warning_ignore("unused_signal")
signal level_loaded

######## Change Values ########
# @warning_ignore("unused_signal")
signal change_enemy_health(add: bool, amount: int)

######## UI ########

signal add_achievement(achievement: String, reward: int)

## dialog lol ##
@warning_ignore("unused_signal")
signal shop_dialog(action: String)
signal finished_displaying

######## VFX ########
@warning_ignore("unused_signal")
signal enemy_visuals()
signal trigger_camera_shake(max: float, fade: float)

# gameplay loop
signal increase_period(inc: int)

# func _ready():
	# skill_check_finish.connect(_on_skill_check)
	# current_enemy_defeated.connect(on_current_enemy_defeated)
	
# func _on_skill_check(success: bool):
# 	if success:
# 		Globals.in_favor = true
# 	else: 
# 		Globals.in_favor = false

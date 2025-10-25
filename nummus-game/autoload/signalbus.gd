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
# signal change_fortune(add: bool, amount: int)
# signal change_misfortune(add: bool, amount: int)
# signal change_health(add: bool, amount: int)
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

# func _on_current_enemy_defeated():
# 	toggle_level_completed_ui.emit(true)

# 	# open win menu


# func on_fortune_changed(add: bool, amount: int):
# 	if Globals.fortune + amount > Globals.max_fortune or Globals.fortune + amount < 0 or amount > Globals.max_fortune:
# 		Globals.fortune = Globals.fortune
# 	elif add:
# 		Globals.fortune += amount
# 	else:
# 		Globals.fortune = amount
		
# func on_misfortune_changed(add: bool, amount: int):
# 	if Globals.misfortune + amount > Globals.max_misfortune or Globals.misfortune + amount < 0 or amount > Globals.max_misfortune:
# 		Globals.misfortune = Globals.max_misfortune
# 	elif add:
# 		Globals.misfortune += amount
# 	else:
# 		Globals.misfortune = amount
		
# func on_health_changed(add: bool, amount: int):
# 	if Globals.health + amount > Globals.max_health or Globals.health + amount < 0 or amount > Globals.max_health:
# 		Globals.health = Globals.health
# 	elif add:
# 		Globals.health += amount
# 	else:
# 		Globals.health = amount

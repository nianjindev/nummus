extends Node

const level_progression: Array[String] = ['limbo', 'lust', 'gluttony', 'greed', 'anger', 'heresy', 'violence', 'fraud', 'treachery']
var current_stage: int # 1 - 3, 3 being the boss
var current_level: String # refers to the level array
var next_stage_scene: String
func _ready() -> void:
	current_stage = 1
	current_level  = level_progression[0]
func next_stage():
	if SceneManager.current_scene.name == "BaseLevel":
		next_stage_scene = Constants.SCENE_PATHS.shop
	elif SceneManager.current_scene.name == "Shop":
		if current_stage == 3:
			current_stage = 1
			current_level = level_progression[level_progression.find(current_level) + 1]
		elif current_level == level_progression[-1]:
			print("you reached the last level")
		else:
			current_stage += 1
		next_stage_scene = Constants.SCENE_PATHS.base_level
	SceneManager.goto_scene(next_stage_scene)
		

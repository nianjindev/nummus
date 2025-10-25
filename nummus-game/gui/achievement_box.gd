extends VBoxContainer

func _ready():
	Signalbus.add_achievement.connect(_add_achievement)

func _add_achievement(achievement: String, reward: int):
	var current_achievement = ResourceLoader.load(Constants.UI_PATHS.achievement_row).instantiate()
	current_achievement.get_node("HBoxContainer").get_node("Achievement").text = achievement
	current_achievement.get_node("HBoxContainer").get_node("Reward").text = "$" + str(reward)
	add_child(current_achievement)

extends VBoxContainer

var achievement_row = preload("res://gui/achievement_row.tscn")

func _ready():
	add_achievement("Winning", 3)

func add_achievement(achievement: String, reward: int):
	var current_achievement = achievement_row.instantiate()
	current_achievement.get_node("HBoxContainer").get_node("Achievement").text = achievement
	current_achievement.get_node("HBoxContainer").get_node("Reward").text = "$" + str(reward)
	add_child(current_achievement)
	

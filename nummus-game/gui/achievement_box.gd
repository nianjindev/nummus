extends VBoxContainer

var achievement_row = preload("res://gui/achievement_row.tscn")

func _ready():
	Signalbus.add_achievement.connect(_on_add_achievement)

func _on_add_achievement(achievement: String, reward: int):
	var current_achievement = achievement_row.instantiate()
	current_achievement.get_node("HBoxContainer").get_node("Achievement").text = achievement
	current_achievement.get_node("HBoxContainer").get_node("Reward").text = "$" + str(reward)
	add_child(current_achievement)
	

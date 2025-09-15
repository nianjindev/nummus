extends Control

@onready var level_1: Button = $Level1
@onready var level_2: Button = $Level2
@onready var level_3: Button = $Level3


func _ready():
	level_2.disabled = true
	level_3.disabled = true
func _on_level_1_pressed() -> void:
	pass

func _on_level_2_pressed() -> void:
	pass # Replace with function body.

func _on_level_3_pressed() -> void:
	pass # Replace with function body.

extends Control

func _ready():
	Globals.next_stage_button = $NextStage

func _on_next_stage_pressed() -> void:
	SceneManager.goto_scene("res://world.tscn")
	Globals.next_stage_button.hide()

extends Control

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	print("Settings")

func _on_play_pressed() -> void:
	SceneManager.goto_scene(Constants.SCENE_PATHS.base_level)
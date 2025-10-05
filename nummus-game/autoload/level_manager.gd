extends Node

func next_stage():
	if SceneManager.current_scene.name == "BaseLevel":
		SceneManager.goto_scene(Constants.SCENE_PATHS.shop)
extends Node

@onready var enemy_base = ResourceLoader.load(Constants.SCENE_PATHS.base_enemy)
@onready var coin_base = ResourceLoader.load(Constants.SCENE_PATHS.base_coin)
var current_enemy: Enemy

func create_coin(coin_path: String, state: Constants.DisplayType) -> Coin:
	var new_coin: Coin
	new_coin = coin_base.instantiate()
	new_coin.current_state = state
	new_coin.coin_id = ResourceLoader.load(coin_path).duplicate(true)
	return new_coin

func spawn_base_enemy():
	current_enemy = enemy_base.instantiate()
	current_enemy.enemy_id = ResourceLoader.load("res://resources/enemies/smug_man.tres")
	SceneManager.current_scene.add_child.call_deferred(current_enemy)

func parse_json(path: String) -> JSON:
	# json parse
	var file = FileAccess.open(path, FileAccess.READ)
	assert(FileAccess.file_exists(path),"File doesnt exist")
	var json = file.get_as_text()
	var json_object: JSON = JSON.new()

	json_object.parse(json)
	return json_object

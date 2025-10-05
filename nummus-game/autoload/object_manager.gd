extends Node

@onready var enemy_base = ResourceLoader.load(Constants.SCENE_PATHS.base_enemy)
@onready var coin_base = ResourceLoader.load(Constants.SCENE_PATHS.base_coin)
var current_enemy: Enemy
var current_coin: Coin

func create_coin(coin_path: String, state: Constants.display_type) -> Coin:
	current_coin = coin_base.instantiate()
	current_coin.current_state = state
	current_coin.coin_id = ResourceLoader.load(coin_path)
	return current_coin

func spawn_base_enemy():
	current_enemy = enemy_base.instantiate()
	current_enemy.enemy_id = ResourceLoader.load("res://resources/enemies/smug_man.tres")
	SceneManager.current_scene.add_child.call_deferred(current_enemy)

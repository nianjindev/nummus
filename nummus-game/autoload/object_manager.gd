extends Node

@onready var enemy_base = ResourceLoader.load(Constants.SCENE_PATHS.base_enemy)
@onready var coin_base = ResourceLoader.load(Constants.SCENE_PATHS.base_coin)
var current_enemy: Enemy
var current_coin: Coin

signal replace_current_coin()

func create_coin(coin_path: String, state: Constants.display_type) -> Coin:
	var new_coin: Coin
	new_coin = coin_base.instantiate()
	new_coin.current_state = state
	new_coin.coin_id = ResourceLoader.load(coin_path).duplicate(true)
	return new_coin

func spawn_base_enemy():
	current_enemy = enemy_base.instantiate()
	current_enemy.enemy_id = ResourceLoader.load("res://resources/enemies/smug_man.tres")
	SceneManager.current_scene.add_child.call_deferred(current_enemy)

func set_current_coin(coin: Coin) -> bool:
	if current_coin == null:
		current_coin = coin
		print("Set the current coin!")
		return true
	else:
		print("Replacing coin")
		current_coin = coin
		replace_current_coin.emit()
		return true

func delete_current_coin():
	print("Removed current coin")
	current_coin = null

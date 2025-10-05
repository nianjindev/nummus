extends Node

@onready var enemy_base = ResourceLoader.load(Constants.SCENE_PATHS.base_enemy)
@onready var coin_base = ResourceLoader.load(Constants.SCENE_PATHS.base_coin)
var current_enemy: Node3D
var current_coin: Node3D

func spawn_base_coin():
	current_coin = coin_base.instantiate()
	current_coin.coin_id = ResourceLoader.load(Constants.COINS.old_abe)
	SceneManager.current_scene.add_child.call_deferred(current_coin)
	Inventory.add_item(current_coin)

func spawn_base_enemy():
	current_enemy = enemy_base.instantiate()
	current_enemy.enemy_id = ResourceLoader.load("res://resources/enemies/smug_man.tres")
	SceneManager.current_scene.add_child.call_deferred(current_enemy)

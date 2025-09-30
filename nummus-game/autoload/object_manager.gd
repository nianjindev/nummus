extends Node

@onready var enemy_base = ResourceLoader.load("res://enemies/enemy.tscn")
@onready var coin_base = ResourceLoader.load("res://coins/coin_base.tscn")
var current_enemy: Node3D
var current_coin: Node3D

func spawn_base_coin():
	current_coin = coin_base.instantiate()
	current_coin.coin_id = preload("res://resources/coins/coin_base.tres")
	current_coin.position = Vector3(0.367, 0.398, -0.017)
	current_coin.scale = Vector3(0.08, 0.08, 0.08)
	current_coin.rotate_y(PI/2)
	SceneManager.current_scene.add_child.call_deferred(current_coin)

func spawn_base_enemy():
	current_enemy = enemy_base.instantiate()
	current_enemy.enemy_id = preload("res://resources/enemies/smug_man.tres")
	current_enemy.position = Vector3(-1.604,1.4,0.0)
	current_enemy.rotate_y(PI/2)
	current_enemy.scale = Vector3(0.2,0.2,0.2)
	SceneManager.current_scene.add_child.call_deferred(current_enemy)
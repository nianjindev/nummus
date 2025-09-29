extends Node

#Initialized in  coin_flip_buttons.gd
var coin_flip_buttons: Control = null
var next_stage_button: Button = null
#Player Stats
var money: int = 0
var health: int = 20
var max_health: int = 20

var in_favor = false

var current_enemy: Node3D
var current_coin: Node3D
@onready var enemy_base = ResourceLoader.load("res://enemies/enemy.tscn")
@onready var coin_base = ResourceLoader.load("res://coins/coin_base.tscn")

signal health_changed
signal money_changed
signal enemy_health_changed

func _ready():
	current_enemy = enemy_base.instantiate()
	current_enemy.enemy_id = preload("res://resources/enemies/smug_man.tres")
	current_enemy.position = Vector3(-1.604,1.4,0.0)
	current_enemy.rotate_y(PI/2)
	current_enemy.scale = Vector3(0.2,0.2,0.2)
	SceneManager.current_scene.add_child.call_deferred(current_enemy)

	current_coin = coin_base.instantiate()
	current_coin.coin_id = preload("res://resources/coins/coin_base.tres")
	current_coin.position = Vector3(0.367, 0.398, -0.017)
	current_coin.scale = Vector3(0.08, 0.08, 0.08)
	current_coin.rotate_y(PI/2)
	SceneManager.current_scene.add_child.call_deferred(current_coin)
	
func _process(_delta: float) -> void:
	if health > max_health:
		health = max_health

func change_money(add: bool, amount: int):
	if add:
		money += amount
	else:
		money = amount
	money_changed.emit()

func change_health(add: bool, amount: int):
	if add:
		health += amount
	else:
		health = amount
	health_changed.emit()
	
func change_current_enemy_health(add: bool, amount: int):
	if add:
		current_enemy.health += amount
	else:
		current_enemy.health = amount
	enemy_health_changed.emit()
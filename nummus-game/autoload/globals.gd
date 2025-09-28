extends Node

#Initialized in  coin_flip_buttons.gd
var coin_flip_buttons: Control = null

#Player Stats
var money: int = 0
var health: int = 20
var max_health: int = 20

var in_favor = false

var current_enemy: Node3D
var current_coin: Node3D
var enemy_easy = ResourceLoader.load("res://enemies/enemy.tscn")
var coin_base = ResourceLoader.load("res://coins/coin_base.tscn")

signal health_changed
signal money_changed
signal enemy_health_changed

func _ready():
	current_enemy = enemy_easy.instantiate()
	current_coin = coin_base.instantiate()
	
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

	

	
	

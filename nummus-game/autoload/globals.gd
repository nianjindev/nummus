extends Node

var money: int = 0
var health: int = 20
var max_health: int = 20

var enemy: Node3D
var enemy_easy = ResourceLoader.load("res://enemies/enemy.tscn")

var coin_guess = ""

signal health_changed
signal money_changed
signal enemy_health_changed

func _ready():
	enemy = enemy_easy.instantiate()
	
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
		enemy.health += amount
	else:
		enemy.health = amount
	enemy_health_changed.emit()
	
	

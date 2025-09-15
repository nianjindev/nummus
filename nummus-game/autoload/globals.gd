extends Node

var money = 0
var health = 20
var max_health = 20

signal health_changed
signal money_changed

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

extends Node

#Initialized in  coin_flip_buttons.gd
var coin_flip_buttons: Control = null
var next_stage_button: Button = null
#Player Stats
var money: int = 0
var health: int = 20
var max_health: int = 20

var in_favor = false # winning the skill check apparently

# signals that interact with GlobalUI
signal health_changed
signal money_changed


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
	if health > max_health:
		health = max_health
	health_changed.emit()
extends Node

#Player Stats
var money: int = 0
var health: int = 20
var max_health: int = 20

var in_favor = false # winning the skill check apparently

# fortune
var fortune_channeled = false
var fortune_channeled_amount = 0.0

var max_fortune: int = 20
var fortune: int = 0
var fortune_gain: int = 5

var max_misfortune: int = 20
var misfortune: int = 0
var misfortune_gain: int = 5

# signals that interact with GlobalUI
signal update_ui

# luck
var head_weight: float = 0.5
var tail_weight: float = 0.5

# hand size
var max_purse:int = 10
var max_hand:int = 5

func change_money(add: bool, amount: int):
	if add:
		money += amount
	else:
		money = amount
	update_ui.emit()

func change_player_health(add: bool, amount:int):
	if health + amount > max_health or health + amount < 0 or amount > max_health:
		health = health
	elif add:
		health += amount
	else:
		health = amount
	update_ui.emit()
	
func reset_weights():
	head_weight = 0.5
	tail_weight = 0.5
	
	#Signalbus.update_side_percent_ui.emit(head_weight, tail_weight)

func reset_fortune():
	if fortune_channeled:
		if fortune >= 20:
			fortune -= 20
		elif fortune >= 12:
			fortune -= 12
		elif fortune >= 8:
			fortune -= 8
		elif fortune >= 4:
			fortune -= 4
		
	fortune_channeled_amount = 0
	fortune_channeled = false
	
	GuiManager.update_fortune_bar_ui.emit()

func can_afford(price:int):
	return price <= money

func change_fortune(add: bool, amount: int):
	if fortune + amount > max_fortune or fortune + amount < 0 or amount > max_fortune:
		fortune = fortune
	elif add:
		fortune += amount
	else:
		fortune = amount
	GuiManager.update_fortune_bar_ui.emit()

func change_misfortune(add: bool, amount: int):
	if misfortune + amount > max_misfortune or misfortune + amount < 0 or amount > max_misfortune:
		misfortune = max_misfortune
	elif add:
		misfortune += amount
	else:
		misfortune = amount
	GuiManager.update_misfortune_bar_ui.emit()

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
	if add:
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
		if Globals.fortune >= 20:
			Globals.fortune -= 20
		elif Globals.fortune >= 12:
			Globals.fortune -= 12
		elif Globals.fortune >= 8:
			Globals.fortune -= 8
		elif Globals.fortune >= 4:
			Globals.fortune -= 4
		
	Globals.fortune_channeled_amount = 0
	fortune_channeled = false
	
	#Signalbus.update_fortune_bar_ui.emit()

func can_afford(price: int) -> bool:
	if price <= money:
		return true
	else:
		return false

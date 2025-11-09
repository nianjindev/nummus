extends Node

#Player Stats
var money: int = 0
var health: int = 20
var max_health: int = 20
var shield: int = 0

var in_favor: bool = false # winning the skill check apparently
var flipping: bool = false

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
var enemy_visuals_finished = false;

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
	GuiManager.update_money_text.emit()

func change_player_health(add: bool, amount:int):
	if add:
		if amount < 0: #if dealing damage
			if shield + amount >= 0: #if shield is active
				change_shield(true, amount)
			else:
				if health + (shield + amount) < 0:
					health = 0
				else:
					health += (shield + amount)
				change_shield(false, 0)
		else:
			if health + amount > max_health:
				health = max_health
			else:
				health += amount
	else:
		if amount < 0:
			health = 0
		elif amount > max_health:
			health = max_health
		else:
			health = amount
	GuiManager.update_health_ui.emit()
	
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

func change_shield(add: bool, amount: int):
	if add:
		if shield + amount < 0:
			shield = 0
		else:
			shield += amount
	else:
		if amount < 0:
			shield = 0
		else:
			shield = amount
		
	GuiManager.update_shield_ui.emit()

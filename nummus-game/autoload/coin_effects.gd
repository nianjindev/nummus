extends Node

signal coin_call(effect: String, stats: Dictionary, side: int)

func _ready() -> void:
	coin_call.connect(post_flip)

func post_flip(effect: String, stats: Dictionary, side: int):
	call(effect, stats, side)

func do_damage(dmg: int):
	Signalbus.change_enemy_health.emit(true, -dmg)
func heal_health(hp: int):
	Globals.change_health(true, hp)
func give_money(money: int):
	Globals.change_money(true, money)

func effect_base(stats: Dictionary, side):
	if side == Sides.HEADS:
		do_damage(stats.get("damage"))
	elif side == Sides.TAILS:
		heal_health(stats.get("heal"))

func effect_old_abe(stats: Dictionary, side):
	if side == Sides.HEADS:
		do_damage(stats.get("damage"))
	elif side == Sides.TAILS:
		pass
func effect_1787(stats: Dictionary, side):
	if side == Sides.HEADS:
		do_damage(stats.get("damage"))
	elif side == Sides.TAILS:
		give_money(stats.get("money"))

extends Node

func do_damage(dmg: int):
	Signalbus.change_enemy_health.emit(true, -dmg)
func heal_health(hp: int):
	Globals.change_player_health(true, 4)
func give_money(money: int):
	Globals.change_money(true, money)

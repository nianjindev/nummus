extends Node

func do_damage(dmg: int):
	Signalbus.change_enemy_health.emit(true, -dmg)
func heal_health(hp: int):
	Signalbus.change_health_and_update_ui.emit(true, hp, true)
func give_money(money: int):
	Globals.change_money(true, money)

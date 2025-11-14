extends Node

func do_damage(dmg: int):
	Signalbus.change_enemy_health.emit(true, -dmg)
func heal_health(hp: int):
	Globals.change_player_health(true, 4)
func give_money(money: int):
	Globals.change_money(true, money)
func give_shield(shield: int):
	Globals.change_shield(true, shield)
func multiply_stat(stats: Dictionary, stat_name: String, factor: float) -> Dictionary:
	if stats.find_key(stat_name) != null:
		stats[stat_name] *= factor
	return stats
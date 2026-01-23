extends Node

class PlayerModifier: #temporary brah hehehehe OHAHHAH
	static func heal_health(hp: int):
		Globals.change_player_health(true, hp)
	static func give_money(money: int):
		Globals.change_money(true, money)
	static func give_shield(shield: int):
		Globals.change_shield(true, shield)
	static func multiply_stat(stats: Dictionary, stat_name: String, factor: float) -> Dictionary:
		if stats.find_key(stat_name) != null:
			stats[stat_name] *= factor
		return stats

class EnemyModifier:
	static func do_damage(dmg: int):
		Signalbus.change_enemy_health.emit(true, -dmg)

class WeightModifier:
	static func favor_heads(val: float):
		inc_favor(val, -val)
	static func favor_tails(val: float):
		inc_favor(-val, val)
	static func inc_favor(head: float = 0, tail: float = 0):
		Globals.head_weight += head
		Globals.tail_weight += tail
	static func set_favor(head: float = 0.5, tail: float = 0.5):
		Globals.head_weight = head
		Globals.tail_weight = tail
	static func mult_favor(head: float = 1, tail: float = 1):
		Globals.head_weight *= head
		Globals.tail_weight *= tail

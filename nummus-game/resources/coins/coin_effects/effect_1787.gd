class_name Effect1787 extends Effect

func effect(stats: Dictionary, side):
	if side == Sides.HEADS:
		CommonEffects.EnemyModifier.do_damage(stats.on_heads.damage)
	elif side == Sides.TAILS:
		CommonEffects.PlayerModifier.give_money(stats.on_tails.money)
func pre_effect(_stats: Dictionary):
	pass
func get_repeat() -> int:
	return repeat
func recurring(stats: Dictionary, _state: int) -> Dictionary:
	return stats

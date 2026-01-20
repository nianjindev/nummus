class_name EffectBase extends Effect

func effect(stats: Dictionary, side):
	if side == Sides.HEADS:
		CommonEffects.do_damage(stats.on_heads.damage)
	elif side == Sides.TAILS:
		CommonEffects.give_shield(stats.on_tails.shield)
func pre_effect(_stats: Dictionary):
	pass # Don't change if there is no pre effect
func recurring(stats: Dictionary, state: int) -> Dictionary:
	return stats

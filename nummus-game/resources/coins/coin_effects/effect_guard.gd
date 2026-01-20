class_name EffectGuard extends Effect

func effect(stats: Dictionary, side):
	if side == Sides.HEADS:
		CommonEffects.give_shield(stats.on_tails.shield)
	elif side == Sides.TAILS:
		CommonEffects.give_shield(stats.on_tails.shield)
func pre_effect(_stats: Dictionary):
	pass # Don't change if there is no pre effect
func recurring(stats: Dictionary, state: Side) -> Dictionary:
	return stats

class_name EffectBase extends Effect

func effect(stats: Dictionary, side):
	if side == Sides.HEADS:
		CommonEffects.do_damage(stats.damage)
	elif side == Sides.TAILS:
		CommonEffects.heal_health(stats.heal)

func pre_effect(_stats: Dictionary):
	pass # Don't change if there is no pre effect

func recurring(_stats: Dictionary):
	pass # Don't change if there is no recurring effect

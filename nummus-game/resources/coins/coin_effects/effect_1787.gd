class_name Effect1787 extends Effect

func effect(stats: Dictionary, side):
	if side == Sides.HEADS:
		CommonEffects.do_damage(stats.damage)
	elif side == Sides.TAILS:
		CommonEffects.heal_health(stats.heal)
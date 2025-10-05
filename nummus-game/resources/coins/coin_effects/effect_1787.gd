class_name Effect1787 extends Effect

func effect(stats: Dictionary, side):
	if side == Sides.HEADS:
		CommonEffects.do_damage(stats.damage)
	elif side == Sides.TAILS:
		CommonEffects.give_money(stats.money)
func pre_effect(_stats: Dictionary):
	pass
func recurring(_stats: Dictionary):
	pass # Don't change if there is no recurring effect

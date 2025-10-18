class_name EffectOldAbe extends Effect

func effect(stats: Dictionary, side):
	if side == Sides.HEADS:
		CommonEffects.do_damage(stats.on_heads.damage)
func pre_effect(_stats: Dictionary):
	Globals.tail_weight = 0
func recurring(_stats: Dictionary):
	pass # Don't change if there is no recurring effect

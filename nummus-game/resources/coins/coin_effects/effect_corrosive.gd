class_name EffectCorrosive extends Effect

func effect(stats: Dictionary, side):
	if side == Sides.HEADS:
		RecursiveEffect.add_recurring(self)
	elif side == Sides.TAILS:
		CommonEffects.give_shield(stats.on_tails.shield)
func pre_effect(_stats: Dictionary):
	pass
func recurring(stats: Dictionary) -> Dictionary:
	print("test")
	CommonEffects.do_damage(3)
	return stats
func set_repeat():
	repeat = 3

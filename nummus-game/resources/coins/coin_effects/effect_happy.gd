extends Effect

func effect(stats: Dictionary, side: int):
	if side == Sides.HEADS:
		RecursiveEffect.add_recurring(self)
	elif side == Sides.TAILS:
		RecursiveEffect.add_recurring(self)
func pre_effect(_stats: Dictionary):
	pass
func set_repeat():
	repeat = 1
func recurring(stats: Dictionary, state: int) -> Dictionary:
	if state == Sides.HEADS:
		CommonEffects.favor_heads(0.25)
	return stats

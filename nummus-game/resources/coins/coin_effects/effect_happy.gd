extends Effect

func effect(stats: Dictionary, side: int):
	if side == Sides.HEADS:
		RecursiveEffect.add_recurring(self)
	elif side == Sides.TAILS:
		RecursiveEffect.add_recurring(self)
func pre_effect(_stats: Dictionary):
	pass
func get_repeat() -> int:
	return repeat
func recurring(stats: Dictionary, state: int) -> Dictionary:
	if state == Sides.HEADS:
		CommonEffects.favor_heads(0.5)
	return stats

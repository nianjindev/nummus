class_name EffectCorrosive extends Effect

func effect(stats: Dictionary, side):
	if side == Sides.HEADS:
		RecursiveEffect.add_recurring_effect(CommonEffects.EnemyModifier.do_damage.bind(3), 3)
	elif side == Sides.TAILS:
		CommonEffects.PlayerModifier.give_shield(stats.on_tails.shield)
func pre_effect(_stats: Dictionary):
	pass

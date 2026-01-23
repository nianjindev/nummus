extends Node

var effects: Dictionary[Callable, int]

var weight_effects: Array[Object] = []

func add_recurring_effect(function: Callable, period_length: int):
	if function.get_object() == CommonEffects.WeightModifier:
		weight_effects.append(RecursiveEffectObject.new(function, period_length))
	else:
		effects[function] = period_length
	print("The number of times I will recur is: " + str(period_length))

func run_recurring_effect(stats: Dictionary, state: int) -> Dictionary:
	for effect in weight_effects:
		if effect.period_length == 0:
			weight_effects.erase(effect)
			continue
			
		effect.period_length -= 1
		effect.run()
	return stats

class RecursiveEffectObject:
	var effect: Callable
	var period_length: int
	
	func _init(given_effect: Callable, given_period_length: int):
		effect = given_effect
		period_length = given_period_length
		
	func run():
		effect.call()

extends Node

var effects: Dictionary[Callable, int]

var weight_effects: Dictionary[Callable, int]

func add_recurring_effect(function: Callable, period_length: int):
	if function.get_object() == CommonEffects.WeightModifier:
		weight_effects[function] = period_length
	else:
		effects[function] = period_length
	print("The number of times I will recur is: " + str(period_length))

func run_recurring_effect(stats: Dictionary, state: int) -> Dictionary:
	for function in weight_effects.keys():
		if weight_effects[function] == 0:
			weight_effects.erase(function)
			continue
			
		weight_effects[function] -= 1
		function.call()
	return stats

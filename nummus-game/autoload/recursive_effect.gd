extends Node

var effects: Dictionary[Callable, int]

func add_recurring_effect(function: Callable, period_length: int):
	effects[function] = period_length
	print("The number of times I will recur is: " + str(period_length))

func run_recurring_effect(stats: Dictionary, state: int) -> Dictionary:
	for function in effects.keys():
		if effects[function] == 0:
			effects.erase(function)
			continue
			
		effects[function] -= 1
		function.call()
	return stats

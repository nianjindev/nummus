extends Node

var recurring: Dictionary[Object, int]

func add_recurring(s: Object):
	s.set_repeat()
	recurring[s] = s.repeat
	print("The number of times I will recur is: " + str(s.get_repeat()))
func run_recurring(stats: Dictionary, state: int) -> Dictionary:
	for s in recurring.keys():
		if recurring[s] == 0:
			recurring.erase(s)
			continue
		recurring[s] -= 1
		stats = apply_single(s, stats, state)
	return stats
func apply_single(s: Object, stats: Dictionary, state: int)->Dictionary:
	stats = s.recurring(stats, state)
	return stats

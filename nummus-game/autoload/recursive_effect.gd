extends Node

var effects: Dictionary[Object, int]

func add_recurring(rec_object: Object):
	rec_object.set_repeat()
	effects[rec_object] = rec_object.repeat
	print("The number of times I will recur is: " + str(rec_object.get_repeat()))

func run_recurring(stats: Dictionary, state: int) -> Dictionary:
	for rec_object in effects.keys():
		if effects[rec_object] == 0:
			effects.erase(rec_object)
			continue
			
		effects[rec_object] -= 1
		stats = apply_single(rec_object, stats, state)
	return stats

func apply_single(rec_object: Object, stats: Dictionary, state: int)->Dictionary:
	stats = rec_object.recurring(stats, state)
	return stats

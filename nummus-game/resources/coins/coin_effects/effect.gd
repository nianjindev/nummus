@abstract 
class_name Effect

var repeat: int = 0

@abstract func effect(stats: Dictionary, side: int)
@abstract func pre_effect(stats: Dictionary)

func get_repeat():
	return repeat
func set_repeat():
	repeat = 0

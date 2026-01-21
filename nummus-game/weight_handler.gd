extends Node

#template that doesnt do anything lol

var queued_weights: Array = []
var is_busy: bool 

func queue_weight(function: Callable):
	queued_weights.append(function)
	try_run_next()

func try_run_next():
	if is_busy:
		return

	if queued_weights.is_empty():
		return

	is_busy = true
	var next_action: Callable = queued_weights.front()
	next_action.call()

func action_finished():
	is_busy = false
	queued_weights.pop_front()
	await get_tree().create_timer(0.25).timeout
	try_run_next()

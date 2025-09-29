extends Node

signal coin_call(effect: String, stats: Dictionary, head_s: bool)

func _ready() -> void:
	coin_call.connect(post_flip)

func post_flip(effect: String, stats: Dictionary, head_s):
	call(effect, stats, head_s)

func coin_base(stats: Dictionary, head_s):
	var damage = stats.get("damage")
	var heal = stats.get("heal")
	if head_s:
		Signalbus.change_enemy_health.emit(true, -damage)
	else:
		Globals.change_health(true, heal)

extends Node

var rng = RandomNumberGenerator.new()
var game_seed = randi()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	seed(game_seed)

func set_seed(new_seed = randi()):
	if new_seed is String:
		new_seed = new_seed.hash()
	game_seed = new_seed
	seed(game_seed)

extends Node

var events = {}
var rng = SeedManager.rng
var light_weights = PackedFloat32Array([1, 0])
var medium_weights = PackedFloat32Array([0.25, 0.75])
var heavy_weights = PackedFloat32Array([0.60, 0.40])
var decision = [true, false]

var light_keys = []
var medium_keys = []
var heavy_keys = []

func _ready():
	var file = FileAccess.open("res://assets/resource_json/misfortune_events.json", FileAccess.READ)
	var json_text = file.get_as_text()
	events = JSON.parse_string(json_text)
	
	light_keys = events["light"].keys()
	medium_keys = events["medium"].keys()
	heavy_keys = events["heavy"].keys()

func check_for_event():
	var current_weights = PackedFloat32Array()
	var event_type = ""
	
	if Globals.misfortune <= 20:
		current_weights = light_weights
	elif Globals.misfortune <= 35:
		current_weights = medium_weights
	elif Globals.misfortune < 50:
		current_weights = heavy_weights
		
	if (decision[rng.rand_weighted(current_weights)]):
		choose_event(event_type)

func choose_event(event_type: String):
	var effect = ""
	var amount = 0
	
	match event_type:
		"light": 
			effect = light_keys[rng.randi_range(0, light_keys.size() - 1)]
			amount = events["light"][effect]
		"medium":
			effect = medium_keys[rng.randi_range(0, medium_keys.size() - 1)]
			amount = events["medium"][effect]
		"heavy":
			effect = heavy_keys[rng.randi_range(0, heavy_keys.size() - 1)]
			amount = events["heavy"][effect]
			
	execute_event(effect, amount)
	
func execute_event(effect: String, amount: int):
	match effect:
		"player_damage":
			Globals.change_player_health(true, -(Globals.max_health * amount))
		"weight":
			Globals.success_weight = amount
			
	GuiManager.show_misfortune_inflicted.emit(effect + ":" + str(amount))
	

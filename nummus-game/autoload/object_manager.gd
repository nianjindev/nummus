extends Node

@onready var enemy_base = ResourceLoader.load(Constants.SCENE_PATHS.base_enemy)
@onready var coin_base = ResourceLoader.load(Constants.SCENE_PATHS.base_coin)
var current_enemy: Enemy
var current_coin: Coin
var current_hand: Array[Coin] = []

signal replace_current_coin()

func _ready() -> void:
	Signalbus.return_spacing.connect(set_spacing)

func set_spacing(positions: Array[Vector3]):
	# They SHOULD be the same
	for i in min(current_hand.size(), positions.size()):
		current_hand[i].tween_pos = positions[i]
	Signalbus.positions_ready.emit()

func create_coin(coin_path: String, state: Constants.display_type) -> Coin:
	var new_coin: Coin
	new_coin = coin_base.instantiate()
	new_coin.current_state = state
	new_coin.coin_id = ResourceLoader.load(coin_path).duplicate(true)
	return new_coin

func spawn_base_enemy():
	current_enemy = enemy_base.instantiate()
	current_enemy.enemy_id = ResourceLoader.load("res://resources/enemies/smug_man.tres")
	SceneManager.current_scene.add_child.call_deferred(current_enemy)

func parse_json(path: String) -> JSON:
	# json parse
	var file = FileAccess.open(path, FileAccess.READ)
	assert(FileAccess.file_exists(path),"File doesnt exist")
	var json = file.get_as_text()
	var json_object: JSON = JSON.new()

	json_object.parse(json)
	return json_object

func set_current_coin(coin: Coin) -> bool:
	if current_coin == null:
		current_coin = coin
		current_hand.remove_at(current_hand.find(current_coin))
		print("Set the current coin!")
		Signalbus.refresh_spacing.emit(current_hand.size())
		return true
	else:
		print("Replacing coin")
		current_hand.append(current_coin) # adds the current coin back into hand
		current_coin = coin # sets new current coin
		current_hand.remove_at(current_hand.find(current_coin))
		Signalbus.refresh_spacing.emit(current_hand.size())
		replace_current_coin.emit()
		return true

func delete_current_coin():
	print("Removed current coin")
	current_hand.append(current_coin)
	Signalbus.refresh_spacing.emit(current_hand.size())
	current_coin = null

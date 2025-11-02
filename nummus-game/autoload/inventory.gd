extends Node

@export var inventory: Array[Coin]
# In game
var temp_inv: Array[Coin]
var discard: Array[Coin]
var current_hand: Array[Coin] = []
signal inventory_changed()
signal replace_current_coin()

var current_coin: Coin

func _ready() -> void:
	Signalbus.return_spacing.connect(set_spacing)

func reset_inv():
	temp_inv.clear()
	discard.clear()
	current_hand.clear()
	current_coin = null

func new_hand():
	var hand_size: int = min(Globals.max_hand, temp_inv.size())
	print(temp_inv.size())
	
	for i in range(hand_size): # Ideally, remove from inventory into hand!
		var new_coin: Coin = Inventory.temp_inv.pick_random()
		new_coin.current_state = Constants.display_type.PLAY
		SceneManager.current_scene.add_child.call_deferred(new_coin)
		temp_inv.remove_at(temp_inv.find(new_coin))
		current_hand.append(new_coin)
	#Signalbus.fly_out.emit()
	Signalbus.refresh_spacing.emit(hand_size)

func fire_game():
	reset_inv()
	for coin in inventory:
		temp_inv.append(coin.duplicate())
	new_hand()

func add_item(item: Coin) -> bool:
	if inventory.size() <= 15:
		inventory.append(item)
		inventory_changed.emit()

		return true
	else:
		return false

func set_spacing(positions: Array[Vector3]):
	# They SHOULD be the same

	for i in min(current_hand.size(), positions.size()):
		current_hand[i].tween_pos = positions[i]
	Signalbus.positions_ready.emit()

func remove_item(item: Coin) -> bool:
	if inventory.find(item) != -1:
		inventory.remove_at(inventory.find(item))
		inventory_changed.emit()
		return true
	else:
		return false

func discard_coin():
	discard.append(current_coin) # needs to be visibly removed!
	current_coin = null

func set_current_coin(coin: Coin) -> bool:
	if current_coin == null:
		current_coin = coin
		current_hand.remove_at(current_hand.find(current_coin))
		Signalbus.refresh_spacing.emit(current_hand.size())
		return true
	else:
		current_hand.append(current_coin) # adds the current coin back into hand
		current_coin = coin # sets new current coin
		current_hand.remove_at(current_hand.find(current_coin))
		Signalbus.refresh_spacing.emit(current_hand.size())
		replace_current_coin.emit()
		return true

func delete_current_coin():
	current_hand.append(current_coin)
	Signalbus.refresh_spacing.emit(current_hand.size())
	current_coin = null

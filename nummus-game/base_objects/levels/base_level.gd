extends Node3D

var current_hand: Array[Coin]
@onready var table = $TableHandler

func _ready() -> void:
	# Inventory.add_item(ObjectManager.create_coin(Constants.COINS.base, Constants.display_type.PLAY))
	spawn_coin()
	ObjectManager.spawn_base_enemy()
	

func spawn_coin():
	var hand_size: int = max(Globals.max_hand, Inventory.inventory.size())
	for i in range(hand_size):
		var new_coin: Coin = Inventory.inventory[i].duplicate()
		current_hand.append(new_coin)
		new_coin.current_state = Constants.display_type.PLAY
		SceneManager.current_scene.add_child.call_deferred(new_coin)
		new_coin.position = table.coin_positions[i]
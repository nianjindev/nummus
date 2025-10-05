extends Node3D

var current_coin: Coin

func _ready() -> void:
	current_coin = ObjectManager.create_coin(Constants.COINS.base, Constants.display_type.PLAY)
	Inventory.add_item(current_coin)
	spawn_coin()
	ObjectManager.spawn_base_enemy()

func spawn_coin():
	SceneManager.current_scene.add_child.call_deferred(Inventory.inventory[0])
	current_coin.position = Vector3(0.367, 0.398, -0.017)
extends Node3D

var current_coin: Coin

func _ready() -> void:
	Inventory.add_item(ObjectManager.create_coin(Constants.COINS.base, Constants.display_type.PLAY))
	spawn_coin()
	ObjectManager.spawn_base_enemy()

func spawn_coin():
	current_coin = Inventory.inventory[0].duplicate()
	SceneManager.current_scene.add_child.call_deferred(current_coin)
	current_coin.position = Vector3(0.367, 0.398, -0.017)
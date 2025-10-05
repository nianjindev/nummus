extends Node3D

enum Shelf{COINS, MINTS, UPGRADES, BLIND_BOXES}

var z_positions: Array[float] = [0.8,0,-0.8]

func _ready() -> void:
	init_coins()

func init_coins():
	for z in z_positions:
		var new_coin: Coin = ObjectManager.create_coin(Constants.COINS.base, Constants.display_type.SHOP)
		self.add_child(new_coin)
		new_coin.position.y = 1.1
		new_coin.position.z = z

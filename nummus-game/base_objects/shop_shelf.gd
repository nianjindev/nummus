extends Node3D

enum Shelf{COINS, MINTS, UPGRADES, BLIND_BOXES}

var z_positions: Array[float] = [0.8,0,-0.8]

func _ready() -> void:
	init_coins()

func init_coins():
	var no_repeat: Array[CoinStats]
	for i in Inventory.inventory:
		no_repeat.append(i.coin_id)
	print(no_repeat)
	for z in z_positions:
		var new_coin_rs = Constants.COINS.values().pick_random()
		while (ResourceLoader.load(new_coin_rs) in no_repeat) and (no_repeat.size() < Constants.COINS.values().size()):
			print("Finding new coin, dupe found")
			new_coin_rs = Constants.COINS.values().pick_random()
		var new_coin: Coin = ObjectManager.create_coin(new_coin_rs, Constants.display_type.SHOP)
		no_repeat.append(new_coin.coin_id)
		self.add_child(new_coin)
		new_coin.position.y = 1.1
		new_coin.position.z = z
		print(no_repeat)

extends Node

@export var inventory: Array[Coin]
@export var discard: Array[Coin]
signal inventory_changed()

func add_item(item: Coin) -> bool:
	if inventory.size() <= 15:
		inventory.append(item)
		inventory_changed.emit()
		print("signal?")
		return true
	else:
		return false

func remove_item(item: Coin) -> bool:
	if inventory.find(item) != -1:
		inventory.remove_at(inventory.find(item))
		inventory_changed.emit()
		return true
	else:
		return false

func discard_coin(item: Coin):
	if inventory.find(item) != -1:
		discard.append(item)
		inventory.remove_at(inventory.find(item))

func refill_inv():
	inventory.append_array(discard)
	discard.clear()

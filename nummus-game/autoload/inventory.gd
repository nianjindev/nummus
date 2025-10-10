extends Node

@export var inventory: Array[Coin]
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

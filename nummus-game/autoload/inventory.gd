extends Node

@export var inventory: Array[Coin]

func add_item(item: Coin) -> bool:
	if inventory.size() <= 10:
		inventory.append(item)
		return true
	else:
		return false

func remove_item(item: Coin) -> bool:
	if inventory.find(item) != -1:
		inventory.remove_at(inventory.find(item))
		return true
	else:
		return false
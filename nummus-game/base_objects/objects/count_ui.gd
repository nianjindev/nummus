extends Label3D

func _ready():
	GuiManager.update_inventory_patch.connect(update_counter)
	
func update_counter(type: String):
	if name == "DiscardCounter":
		text = str(Inventory.discard.size())
	if name == "InventoryCounter":
		text = str(Inventory.current_inv.size())

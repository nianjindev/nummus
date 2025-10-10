extends Control

@onready var container: HBoxContainer = $HBoxContainer

func _ready() -> void:
	update_slots()
	Inventory.inventory_changed.connect(update_slots)

func update_slots():
	for n in container.get_children():
		container.remove_child(n)
		n.queue_free()
	for coin in Inventory.inventory:
		var subviewp: SubViewportContainer = SubViewportContainer.new()
		var viewp: SubViewport = SubViewport.new()
		subviewp.add_child(viewp)
		viewp.add_child(coin.duplicate())
		viewp.size = Vector2(165, 165)
		viewp.transparent_bg = true
		coin.current_state = Constants.display_type.HAND

		container.add_child(subviewp)


		
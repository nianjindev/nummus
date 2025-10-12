extends Control

@onready var container: GridContainer = $ColorRect/GridContainer

func _ready() -> void:
	update_inventory(Inventory.inventory)

func update_inventory(coins: Array[Coin]):
	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()
	for coin in coins:
		var texture: AtlasTexture = AtlasTexture.new()
		texture.atlas = coin.coin_id.coin_texture
		texture.region = Rect2(2, 0, 15, 15)
		var new_textrect: TextureRect = TextureRect.new()
		new_textrect.texture = texture
		container.add_child(new_textrect)
		new_textrect.texture = texture

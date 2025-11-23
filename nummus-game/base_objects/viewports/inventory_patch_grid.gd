extends GridContainer

const ID_icon = preload(Constants.UI_PATHS.ID_icon)
@onready var patch: PanelContainer = $"../.."
var path: Array[Coin]
var icons = {}

func _ready():
	icons.clear()
	GuiManager.update_inventory_patch.connect(update_ui)
	set_path()
	initialize_icons()

func update_ui(type: String):
	if type == patch.name:
		for child in get_children(): #WOW HOW INEFFCIENT
			child.queue_free()
		
		for coin in path:
			var current_instance = ID_icon.instantiate()
			set_icon(coin, current_instance)
			add_child(current_instance)
			

func initialize_icons():
	for coin in Inventory.inventory:
		if coin.coin_id.coin_texture not in icons:
			var texture = AtlasTexture.new()
			texture.atlas = coin.coin_id.coin_texture
			texture.region = Rect2(2, 0, 15, 15)
			icons[coin.coin_id.coin_texture] = texture
	
func set_icon(coin, current_instance):
	current_instance.texture = icons[coin.coin_id.coin_texture]
	current_instance.custom_minimum_size = Vector2(64, 64)

func set_path():
	if patch.name == "Inventory":
		path = Inventory.current_inv
	elif patch.name == "Discard":
		path = Inventory.discard
	else:
		print("PATH NOT SET!!!!!!")
	

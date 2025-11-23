extends GridContainer

const ID_icon = preload(Constants.UI_PATHS.ID_icon)
@onready var patch: PanelContainer = $"../.."
var path: Array[Coin]

func _ready():
	GuiManager.update_inventory_patch.connect(update_ui)
	print(patch.name)
	set_path()

func update_ui(type: String):
	if type == patch.name:
		for child in get_children(): #WOW HOW INEFFCIENT
			child.queue_free()
		
		for coin in path:
			var current_instance = ID_icon.instantiate()
			initialize_icon(coin, current_instance)
			add_child(current_instance)
			

func initialize_icon(coin, current_instance):
	current_instance.texture = AtlasTexture.new()
	current_instance.texture.atlas = coin.coin_id.coin_texture
	current_instance.texture.region = Rect2(2, 0, 15, 15)
	current_instance.custom_minimum_size = Vector2(64, 64)

func set_path():
	if patch.name == "Inventory":
		path = Inventory.current_inv
	elif patch.name == "Discard":
		path = Inventory.discard
	else:
		print("PATH NOT SET!!!!!!")
	

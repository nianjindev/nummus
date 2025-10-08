extends Node3D

class_name Coin

# children
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var coin_mesh: MeshInstance3D = $CoinMesh
@onready var hoverable: Node3D = $Hoverable
@onready var area: Area3D = $Area3D

# flipping
var sides = [Sides.HEADS, Sides.TAILS]
var weights: Array[float] = [0.5, 0.5]

# coin stats
@export var coin_id: CoinStats
var coin_json_id: String
var coin_stats: Dictionary
var coin_effect: RefCounted
var coin_price: int

# coin state
@export var current_state: Constants.display_type
var is_mouse_over: bool = false

# func _init(state: Constants.display_type) -> void:
# 	current_state = state

func _ready():
	# flip signal
	if current_state == null:
		current_state = Constants.display_type.SHOP
	Signalbus.coin_flipped.connect(flip)

	# instance of coin resources
	coin_mesh.material_override = StandardMaterial3D.new()
	coin_mesh.material_override.albedo_texture = coin_id.coin_texture
	coin_mesh.material_override.texture_filter = 0

	# stats and names
	# coin_stats = coin_id.coin_stats
	coin_effect = coin_id.effect.new()
	coin_json_id = coin_id.json_id
	# self.name = coin_id.name
	# hoverable.description.text = coin_id.description + generate_description(coin_stats)
	
	# coin_price = coin_id.price
	# hoverable.title.text = coin_id.name + " [color=yellow]$" + str(coin_price) + "[/color]"

	# change material
	coin_mesh.material_override.metallic_specular = 0.0

	# transform me
	if current_state == Constants.display_type.PLAY:
		scale = Vector3(0.1,0.1,0.1)
	elif current_state == Constants.display_type.SHOP:
		scale = Vector3(0.3,0.3,0.3)
		rotate_z(-PI/2)

	# json parse
	var file = FileAccess.open(Constants.JSON_PATHS.coins, FileAccess.READ)
	assert(FileAccess.file_exists(Constants.JSON_PATHS.coins),"File doesnt exist")
	var json = file.get_as_text()
	var json_object = JSON.new()

	json_object.parse(json)
	for coin in json_object.data:
		if coin == coin_json_id:
			print("matched " + coin)
			coin_stats = json_object.data.get(coin).get("coin_stats")
			self.name = json_object.data.get(coin).get("name")
			coin_price = json_object.data.get(coin).get("price")
			hoverable.title.text = json_object.data.get(coin).get("name") + " [color=yellow]$" + str(coin_price) + "[/color]"
			hoverable.description.text = json_object.data.get(coin).get("description") + generate_description(coin_stats)
			
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	Signalbus.toggle_coin_flip_ui.emit(true)
	
	match anim_name:
		"flip_heads_success":
			coin_effect.effect(coin_stats, Sides.HEADS)
		"flip_heads_fail": # IDEA: all fails do misfortune
			Signalbus.change_fortune_and_update_ui.emit(true, 20, true)
			Signalbus.change_misfortune_and_update_ui.emit(true, 20, true)
			return
		"flip_tails_success":
			coin_effect.effect(coin_stats, Sides.TAILS)
		"flip_tails_fail":
			Signalbus.change_fortune_and_update_ui.emit(true, 20, true)
			Signalbus.change_misfortune_and_update_ui.emit(true, 20, true)
			return
	
	Globals.reset_weights()

func check_flipped_side(flipped_side: int, state: int):
	#flipped side = index returned by weighted array
	if sides[flipped_side] == Sides.HEADS:
		if state == Sides.HEADS:
			animation_player.play("flip_heads_success")
			print("Correct")
		else:
			animation_player.play("flip_heads_fail")
			
			print("Wrong")
	else:
		if state == Sides.TAILS:
			animation_player.play("flip_tails_success")
			print("Correct")
		else:
			animation_player.play("flip_tails_fail")
			
			print("Wrong")

func set_weights():
	weights.set(sides.find(Sides.HEADS), Globals.head_weight)
	weights.set(sides.find(Sides.TAILS), Globals.tail_weight)
		
func flip(state: int):
	if state == Sides.SKIP:
		return
	else:
		Signalbus.toggle_coin_flip_ui.emit(false)
		coin_effect.pre_effect(coin_stats)
		
	var rng = RandomNumberGenerator.new()
	set_weights()
	
	check_flipped_side(rng.rand_weighted(weights), state)

func generate_description(stats: Dictionary) -> String: # on heads: damage:5 ; on tails: heal:5 (example dictionary)
	var s: String = "[br]"
	for i in stats:
		# look for on heads
		if i == "on_heads":
			s += "On Heads:[br]"
			for j in stats.get(i):
				for k in stats.get(i).values():
					s += get_stat_line(j,k)
		elif i == "on_tails" and stats.get(i).size() > 0:
			s += "On Tails:[br]"
			for j in stats.get(i):
				for k in stats.get(i).values():
					s += get_stat_line(j,k)
	return s
func get_stat_line(type: String, value: int):
	match type:
		"damage":
			return "[color=red]" + str(value) + " DMG[/color][br]"
		"heal":
			return "[color=green]" + str(value) + " HP[/color][br]"
		"money":
			return "[color=yellow]$" + str(value) + "[/color][br]"
	return "[color=blue]" + str(value) + " " + type + "[/color][br]"
func toggle_visible(on: bool):
	hoverable.visible = on
func _on_area_3d_mouse_entered() -> void:
	if current_state == Constants.display_type.SHOP:
		toggle_visible(true)
		is_mouse_over = true
func _input(event: InputEvent) -> void:
	if is_mouse_over and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		buy_me()
func _on_area_3d_mouse_exited() -> void:
	toggle_visible(false)
	is_mouse_over = false
func buy_me():
	if Globals.can_afford(coin_price):
		Inventory.inventory.append(self.duplicate())
		Globals.change_money(true, -coin_price)
	else:
		print("you broke lol")

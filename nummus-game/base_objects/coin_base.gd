extends Node3D

class_name Coin

@export var damage: int = 1
@export var level: int = 1
@export var ability: String = "none"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var coin_mesh: MeshInstance3D = $CoinMesh
var sides = ["heads", "tails"]
var weights = PackedFloat32Array([1,1])

@export var coin_id: CoinStats
var coin_stats: Dictionary
var coin_effect: RefCounted

func _ready():
	# flip signal
	Signalbus.coin_flipped.connect(flip)

	# instance of coin resources
	coin_mesh.material_override = StandardMaterial3D.new()
	coin_mesh.material_override.albedo_texture = coin_id.coin_texture
	coin_mesh.material_override.texture_filter = 0
	coin_stats = coin_id.coin_stats
	coin_effect = coin_id.effect.new()

	# transform me
	position = Vector3(0.367, 0.398, -0.017)
	scale = Vector3(0.1,0.1,0.1)
	
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

func check_flipped_side(flipped_side: int, state:String):
	#flipped side = index returned by weighted array
	if sides[flipped_side] == "heads":
		if state == "heads":
			animation_player.play("flip_heads_success")
			print("Correct")
		else:
			animation_player.play("flip_heads_fail")
			
			print("Wrong")
	else:
		if state == "tails":
			animation_player.play("flip_tails_success")
			print("Correct")
		else:
			animation_player.play("flip_tails_fail")
			
			print("Wrong")
	

	
func set_weights(state:String):
	#If player completes skill check, increases their chosen side's weight
	if Globals.in_favor:
		weights.set(sides.find(state), 2) 
		
func flip(state: String):
	if state == "skip":
		return
	else:
		Signalbus.toggle_coin_flip_ui.emit(false)
		
	var rng = RandomNumberGenerator.new()
	print("Got signal coin_flipped")
	Signalbus.skill_check_begin.emit(50, 180, 4)
	await Signalbus.skill_check_finish
	print("skill check finished, state %s" % state)
		
	set_weights(state)
	
	check_flipped_side(rng.rand_weighted(weights), state)
	

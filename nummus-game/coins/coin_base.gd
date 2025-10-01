extends MeshInstance3D

@export var damage: int = 1
@export var level: int = 1
@export var ability: String = "none"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var sides = ["heads", "tails"]
var weights = PackedFloat32Array([1,1])

@export var coin_id: Coin
var coin_func: String
var coin_stats: Dictionary

func _ready():
	# flip signal
	Signalbus.coin_flipped.connect(flip)

	# instance of coin resources
	self.material_override = StandardMaterial3D.new()
	self.material_override.albedo_texture = coin_id.coin_texture
	self.material_override.texture_filter = 0
	coin_func = coin_id.coin_effect
	coin_stats = coin_id.coin_stats
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	Signalbus.toggle_ui.emit(true)
	
	match anim_name:
		"flip_heads_success":
			CoinEffects.coin_call.emit(coin_func, coin_stats, true)
		"flip_heads_fail": # IDEA: all fails do misfortune
			return
		"flip_tails_success":
			CoinEffects.coin_call.emit(coin_func, coin_stats, false)
		"flip_tails_fail":
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
		# IDEA: maybe being in favor and skipping gives money
		return
	else:
		Signalbus.toggle_ui.emit(false)
		
	var rng = RandomNumberGenerator.new()
	print("Got signal coin_flipped")
	Signalbus.skill_check_begin.emit(50, 180, 4)
	await Signalbus.skill_check_finish
	print("skill check finished, state %s" % state)
		
	set_weights(state)
	
	check_flipped_side(rng.rand_weighted(weights), state)
	

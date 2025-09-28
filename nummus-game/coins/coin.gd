extends Node3D

class_name Coin
var skill_check = "res://gui/skill_check.tscn"

@export var damage: int = 1
@export var level: int = 1
@export var ability: String = "none"
@onready var animation_player: AnimationPlayer = $CoinMesh/AnimationPlayer
@onready var coin_mesh: MeshInstance3D = $CoinMesh
var sides = ["heads", "tails"]
var weights = PackedFloat32Array([1,1])

func _ready():
	Signalbus.coin_flipped.connect(flip)
	
func run_successful_heads_effect():
	Signalbus.change_enemy_health.emit(true, -damage)
	
func run_successful_tails_effect():
	Globals.change_health(true, 1)	
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	Globals.coin_flip_buttons.show()
	
	match anim_name:
		"flip_heads_success":
			run_successful_heads_effect()
		"flip_heads_fail":
			return
		"flip_tails_success":
			run_successful_tails_effect()
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
		Globals.coin_flip_buttons.hide()
		
	var rng = RandomNumberGenerator.new()
	print("Got signal coin_flipped")
	Signalbus.skill_check_begin.emit(2)
	await Signalbus.skill_check_finish
	print("skill check finished, state %s" % state)
		
	set_weights(state)
	
	check_flipped_side(rng.rand_weighted(weights), state)
	

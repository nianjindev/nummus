extends Node3D

class_name Coin
var skill_check = "res://gui/skill_check.tscn"

@export var damage: int = 3
@export var level: int = 1
@export var ability: String = "none"
@onready var animation_player: AnimationPlayer = $CoinMesh/AnimationPlayer
@onready var coin_mesh: MeshInstance3D = $CoinMesh
var sides = ["heads", "tails"]
var default_weights = PackedFloat32Array([1,1])

func _ready():
	Signalbus.coin_flipped.connect(flip)
	
func flip(state: String):
	var rng = RandomNumberGenerator.new()
	var temp_weights
	print("Got signal coin_flipped")
	Signalbus.skill_check_begin.emit(2)
	await Signalbus.skill_check_finish
	print("skill check finished, state %s" % state)
	if state == "skip":
		# IDEA: maybe being in favor and skipping gives money
		return
	if Globals.in_favor:
		var temp_array = [1, 1]
		temp_array.set(sides.find(state), 2)
		temp_weights = PackedFloat32Array(temp_array)
		if sides[rng.rand_weighted(temp_weights)] == "heads":
			animation_player.play("flip_heads")
			if state == "heads":
				print("Correct")
		else:
			animation_player.play("flip_tails")
			if state == "tails":
				print("Wrong")
	else:
		if sides[rng.rand_weighted(default_weights)] == "heads":
			animation_player.play("flip_heads")
			if state == "heads":
				print("Correct")
			else:
				print("Wrong")
		else:
			animation_player.play("flip_tails")
			if state == "tails":
				print("Correct")
			else:
				print("Wrong")
	
	


	

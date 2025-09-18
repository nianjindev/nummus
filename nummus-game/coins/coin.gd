extends Node3D

class_name Coin

@export var damage: int = 3
@export var level: int = 1
@export var ability: String = "none"
@onready var animation_player: AnimationPlayer = $CoinMesh/AnimationPlayer
@onready var coin_mesh: MeshInstance3D = $CoinMesh
var my_array = ["heads", "tails"]
var weights = PackedFloat32Array([1,1])

func _ready():
	Signalbus.connect("coin_flipped", Callable(flip))
	
func flip():
	var rng = RandomNumberGenerator.new()
	if my_array[rng.rand_weighted(weights)] == "heads":
		animation_player.play("flip_heads")
		if Globals.coin_guess == "heads":
			print("Correct")
	else:
		animation_player.play("flip_tails")
		if Globals.coin_guess == "tails":
			print("Wrong")
	


	

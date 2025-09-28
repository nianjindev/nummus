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
	
	
func run_heads_effect():
	Signalbus.change_enemy_health.emit(true, -damage)
	
func run_tails_effect():
	Globals.change_health(true, 1)	

func check_flipped_side(flipped_side: int, state:String):
	#flipped side = index returned by weighted array
	Signalbus.change_game_ui_coin_flip_button_visibility.emit(false) #Hides Game UI at the beginning of the flip
	
	if sides[flipped_side] == "heads":
		animation_player.play("flip_heads")
		if state == "heads":
			run_heads_effect()
			print("Correct")
		else:
			print("Wrong")
	else:
		animation_player.play("flip_tails")
		if state == "tails":
			run_tails_effect()
			print("Correct")
		else:
			print("Wrong")
	
func set_weights(state:String):
	#If player completes skill check, increases their chosen side's weight
	if Globals.in_favor:
		weights.set(sides.find(state), 2) 
		
func flip(state: String):
	var rng = RandomNumberGenerator.new()
	print("Got signal coin_flipped")
	Signalbus.skill_check_begin.emit(2)
	await Signalbus.skill_check_finish
	print("skill check finished, state %s" % state)
	if state == "skip":
		# IDEA: maybe being in favor and skipping gives money
		return
		
	set_weights(state)
	
	check_flipped_side(rng.rand_weighted(weights), state)
	
	


	

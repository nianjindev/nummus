extends RigidBody3D

class_name Coin

@export var damage: int = 3
@export var level: int = 1
@export var ability: String = "none"
@onready var animation_player: AnimationPlayer = $CoinMesh/AnimationPlayer
@onready var coin_mesh: MeshInstance3D = $CoinMesh

func _ready():
	Signalbus.connect("coin_flipped", Callable(flip))
	
func flip():
	animation_player.play("flip_heads")
	
#
#func _physics_process(delta: float) -> void:
	#move_and_collide(Vector3(0,9.8*delta,0))

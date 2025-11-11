extends Label3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	animation_player.play("appear")

func terminate():
	queue_free()

extends Camera3D

@export var max_shake: float = .25
@export var shake_fade: float = 10

var _shake_strength: float = 0

func _ready():
	Signalbus.enemy_hurt_visuals.connect(_on_enemy_hurt)

func trigger_shake() -> void:
	_shake_strength = max_shake

func _process(delta: float):
	if _shake_strength > 0:
		_shake_strength = lerp(_shake_strength, 0.0, shake_fade * delta)
		h_offset = randf_range(-_shake_strength , _shake_strength)
		v_offset = randf_range(-_shake_strength , _shake_strength)

func _on_enemy_hurt():
	trigger_shake()

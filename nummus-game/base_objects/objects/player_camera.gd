extends Camera3D

@export var max_shake: float = .25
@export var shake_fade: float = 10

var _shake_strength: float = 0

func _ready():
	Signalbus.trigger_camera_shake.connect(trigger_shake)

func trigger_shake(max: float, fade: float) -> void:
	max_shake = max
	shake_fade = fade
	_shake_strength = max_shake

func _process(delta: float):
	if _shake_strength > 0:
		_shake_strength = lerp(_shake_strength, 0.0, shake_fade * delta)
		h_offset = randf_range(-_shake_strength , _shake_strength)
		v_offset = randf_range(-_shake_strength , _shake_strength)


	

extends Camera3D

@export var max_shake: float = .25
@export var shake_fade: float = 10

var _shake_strength: float = 0

func _ready():
	Signalbus.enemy_visuals.connect(_on_enemy_visuals_played)

func trigger_shake() -> void:
	_shake_strength = max_shake

func set_shake_intensity(max: float, fade: float) -> void:
	max_shake = max
	shake_fade = fade

func _process(delta: float):
	if _shake_strength > 0:
		_shake_strength = lerp(_shake_strength, 0.0, shake_fade * delta)
		h_offset = randf_range(-_shake_strength , _shake_strength)
		v_offset = randf_range(-_shake_strength , _shake_strength)

func enemy_hurt():
	set_shake_intensity(.25, 10)
	trigger_shake()

func _on_enemy_visuals_played(visual: String):
	match visual:
		"hurt":
			enemy_hurt()

extends Camera3D

@export var max_shake: float = .25
@export var shake_fade: float = 10

var _shake_strength: float = 0

func _ready():
	Signalbus.enemy_visuals.connect(_on_enemy_visuals_played)

func trigger_shake(max: float, fade: float) -> void:
	max_shake = max
	shake_fade = fade
	_shake_strength = max_shake

func _process(delta: float):
	if _shake_strength > 0:
		_shake_strength = lerp(_shake_strength, 0.0, shake_fade * delta)
		h_offset = randf_range(-_shake_strength , _shake_strength)
		v_offset = randf_range(-_shake_strength , _shake_strength)

func enemy_hurt():
	trigger_shake(.10, 10)
	
func enemy_death():
	trigger_shake(1, 10)
	await get_tree().create_timer(1).timeout
	trigger_shake(1, 10)
	await get_tree().create_timer(1).timeout
	trigger_shake(1, 3)

func _on_enemy_visuals_played(visual: String):
	match visual:
		"hurt":
			enemy_hurt()
		"death":
			enemy_death()

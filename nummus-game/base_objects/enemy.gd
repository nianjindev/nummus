extends Node3D

class_name Enemy

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health_text: Label3D = $EnemySprite/HealthText
@export var enemy_id: EnemyStats
@onready var animated_sprite: AnimatedSprite3D = $EnemySprite

var max_health: int
var health: int

var hurt_small_length: float = 0.5
var hurt_medium_length: float = 1
var death_length: float = 3.0


func _ready():
	Signalbus.change_enemy_health.connect(change_health)
	animated_sprite.sprite_frames = enemy_id.enemy_expressions
	health = enemy_id.health
	max_health = enemy_id.health
	animated_sprite.play("neutral")
	health_text.text = str(health as int)+"/" + str(max_health)
	# transform
	position = Vector3(-1.604,1,0.0)
	rotate_y(PI/2)
	scale = Vector3(0.6,0.6,0.6)
	Signalbus.enemy_visuals.connect(on_enemy_visuals_played)

func on_enemy_visuals_played(visual: String):
	match visual:
		"none":
			Signalbus.toggle_coin_flip_ui.emit(true)
		"death":
			play_death_animation()
		"hurt":
			play_hurt_animation()
		

func play_hurt_animation():
	animated_sprite.play("hurt")
	animation_player.speed_scale = 0
	
	await get_tree().create_timer(hurt_small_length).timeout
	
	animated_sprite.play("neutral")
	animation_player.speed_scale = 1
	
	Signalbus.toggle_coin_flip_ui.emit(true)

func play_death_animation():
	animated_sprite.play("very_hurt")
	animation_player.speed_scale = 0
	Signalbus.toggle_coin_flip_ui.emit(false)

	await get_tree().create_timer(3).timeout
	
	Signalbus.current_enemy_defeated.emit()

func take_damage(amount: int):
	if health + amount < 0 or health + amount == 0:
		health = 0
		Signalbus.enemy_visuals.emit("death")
	else:
		health += amount
		Signalbus.enemy_visuals.emit("hurt")

func heal(amount: int):
	health += amount

func change_health(add: bool, amount: int):
	if add:
		if amount < 0:
			take_damage(amount)
		else:
			heal(amount)
	else:
		if amount < health:
			take_damage(amount - health)
		else:
			heal(health - amount)
	health_text.text = str(health as int)+"/" + str(max_health)

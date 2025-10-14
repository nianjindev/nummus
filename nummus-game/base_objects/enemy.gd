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

func play_hurt_animation():
	Signalbus.enemy_hurt_visuals.emit()
	animated_sprite.play("hurt")
	animation_player.speed_scale = 0
	
	await get_tree().create_timer(hurt_small_length).timeout
	
	animated_sprite.play("neutral")
	animation_player.speed_scale = 1
	
	
	
func play_death_animation():
	Signalbus.enemy_hurt_visuals.emit()
	animated_sprite.play("very_hurt")
	
	Signalbus.toggle_coin_flip_ui.emit(false)
	animation_player.speed_scale = 0
	
	await get_tree().create_timer(death_length).timeout
	
	Signalbus.current_enemy_defeated.emit()

func take_damage(amount: int):
	if health + amount < 0 or health + amount == 0:
		health = 0
		play_death_animation()
	else:
		health += amount
		play_hurt_animation()

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

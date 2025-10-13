extends Node3D

class_name Enemy

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health_text: Label3D = $EnemySprite/HealthText
@export var enemy_id: EnemyStats
@onready var animated_sprite: AnimatedSprite3D = $EnemySprite
var health: int

func _ready():
	Signalbus.change_enemy_health.connect(change_health)
	health = enemy_id.health
	animated_sprite.sprite_frames = enemy_id.enemy_expressions
	animated_sprite.play("neutral")

	# transform
	position = Vector3(-1.604,1,0.0)
	rotate_y(PI/2)
	scale = Vector3(0.6,0.6,0.6)

func play_hurt_animation():
	animated_sprite.play("hurt")
	animation_player.play("hurt_small")
	await animation_player.animation_finished
	animated_sprite.play("neutral")
	animation_player.play("idle")

func play_death_animation():
	animated_sprite.play("very_hurt")
	animation_player.play("death")
	await animation_player.animation_finished
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
	health_text.text = str(health as int)+"/5"

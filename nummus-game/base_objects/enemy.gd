extends Node3D

class_name Enemy

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


	
func change_health(add: bool, amount: int):
	if add:
		if health + amount < 0 or health + amount == 0:
			health = 0
			Signalbus.current_enemy_defeated.emit()
		else:
			health += amount
	else:
		health = amount
	health_text.text = str(health as int)+"/5"

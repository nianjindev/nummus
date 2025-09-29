extends AnimatedSprite3D

@onready var health_text: Label3D = $HealthText
@export var enemy_id: Enemy
var health: int

func _ready():
	Signalbus.change_enemy_health.connect(change_health)
	health = enemy_id.health
	sprite_frames = enemy_id.enemy_expressions


	
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

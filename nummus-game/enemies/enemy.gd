extends Node3D

@onready var health_text: Label3D = $MeshInstance3D/HealthText

var health = 5

func _ready():
	Signalbus.change_enemy_health.connect(change_health)
	
func change_health(add: bool, amount: int):
	if add:
		health += amount
	else:
		health = amount
	health_text.text = str(health as int)+"/5"

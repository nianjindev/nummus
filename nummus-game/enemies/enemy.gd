extends Node3D

@onready var health_text: Label3D = $MeshInstance3D/HealthText

var health = 5

func _ready():
	Signalbus.change_enemy_health.connect(change_health)
	
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

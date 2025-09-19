extends Node3D

@onready var health_text: Label3D = $MeshInstance3D/HealthText

var health = 5

func _ready():
	Globals.connect("enemy_health_changed", Callable(change_health))
	
func change_health():
	health_text.text = str(Globals.health as int)+"/5"

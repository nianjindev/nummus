extends Node3D


func _ready() -> void:
	Inventory.fire_game()
	#Inventory.spawn_hand()
	ObjectManager.spawn_base_enemy()
	Signalbus.current_enemy_defeated.connect(_on_current_enemy_defeated)

func _on_current_enemy_defeated():
	GuiManager.toggle_level_completed_ui.emit(true)

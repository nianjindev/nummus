extends Node3D

func _ready() -> void:
	await GuiManager.gui_spawned
	GuiManager.show_global_ui()
	ObjectManager.spawn_base_coin()
	ObjectManager.spawn_base_enemy()
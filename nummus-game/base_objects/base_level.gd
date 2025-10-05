extends Node3D

func _ready() -> void:
	SceneManager.current_scene.add_child.call_deferred(ObjectManager.spawn_base_coin())
	ObjectManager.spawn_base_enemy()

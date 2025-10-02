extends Control

class_name Debug

@onready var VBox: VBoxContainer = $PanelContainer/VBoxContainer

const fps_ms: int = 16

func _ready() -> void:
	visible = false


func _input(event: InputEvent) -> void:
	if OS.is_debug_build():
		if event.is_action_pressed("debug"):
			print("Toggled Debug")
			visible = not visible
			get_viewport().set_input_as_handled()
		if event.is_action_pressed("reload"):
			print("I will not reload the scene")

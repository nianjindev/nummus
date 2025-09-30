extends Node

signal gui_spawned

var global_ui_path: String = "res://gui/global_ui.tscn"
var game_ui_path: String = "res://gui/game_ui.tscn"
var skill_check_path: String = "res://gui/skill_check.tscn"

var global_ui: Control
var game_iu: Control
var skill_check: Control

func _ready() -> void:
	spawn_all.call_deferred()

func spawn_all():
	global_ui = ResourceLoader.load(global_ui_path).instantiate()
	game_iu = ResourceLoader.load(game_ui_path).instantiate()
	skill_check = ResourceLoader.load(skill_check_path).instantiate()
	gui_spawned.emit()

func show_global_ui():
	global_ui.visible = true
func hide_global_ui():
	global_ui.visible = false

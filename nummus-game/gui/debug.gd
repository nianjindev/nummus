extends Control

class_name Debug

@onready var container: VBoxContainer = $PanelContainer/VBoxContainer

@onready var fps: Label = $PanelContainer/VBoxContainer/FPS
@onready var give_money: Button = $PanelContainer/VBoxContainer/give_money
@onready var next_stage: Button = $PanelContainer/VBoxContainer/next_stage
@onready var take_dmg: Button = $PanelContainer/VBoxContainer/take_dmg

func _ready() -> void:
	visible = false
	give_money.pressed.connect(Globals.change_money.bind(true, 20))
	next_stage.pressed.connect(LevelManager.next_stage)
	take_dmg.pressed.connect(Globals.change_player_health.bind(true, -5))
func _input(event: InputEvent) -> void:
	if OS.is_debug_build():
		if event.is_action_pressed("debug"):
			print("Toggled Debug")
			visible = not visible
			get_viewport().set_input_as_handled()
		if event.is_action_pressed("reload"):
			print("I will not reload the scene")

func _process(_delta: float) -> void:
	fps.text = "FPS: " + str(Engine.get_frames_per_second())
	
func _on_kill_enemy_pressed() -> void:
	Signalbus.change_enemy_health.emit(true, -1000000)

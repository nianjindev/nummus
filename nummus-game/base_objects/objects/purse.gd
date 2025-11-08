extends Node3D

@onready var hover_area: Area3D = $HoverArea
@onready var opened_mesh: MeshInstance3D = $PurseMeshOpened
@onready var closed_mesh: MeshInstance3D = $PurseMeshClosed

var is_mouse_over: bool = false

func _ready() -> void:
	hover_area.mouse_entered.connect(toggle_opened.bind(true))
	hover_area.mouse_exited.connect(toggle_opened.bind(false))

func toggle_opened(on: bool):
	is_mouse_over = on
	opened_mesh.visible = on
	closed_mesh.visible = not on

func _input(event: InputEvent) -> void:
	if is_mouse_over and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Clicked ts") #make inventory appear here

extends Node3D

@onready var hover_area: Area3D = $HoverArea
@onready var opened_mesh: MeshInstance3D = $PurseMeshOpened
@onready var closed_mesh: MeshInstance3D = $PurseMeshClosed

func _ready() -> void:
	hover_area.mouse_entered.connect(toggle_opened.bind(true))
	hover_area.mouse_exited.connect(toggle_opened.bind(false))

func toggle_opened(on: bool):
	opened_mesh.visible = on
	closed_mesh.visible = not on

extends Node3D

@onready var hover_area: Area3D = $HoverArea
@onready var opened_mesh: MeshInstance3D = $PurseMeshOpened
@onready var closed_mesh: MeshInstance3D = $PurseMeshClosed
@onready var discard_ui: Sprite3D = $"../PurseDiscard/DiscardUI"
@onready var inventory_ui: Sprite3D = $"../PurseInv/InventoryUI"

var is_mouse_over: bool = false

func _ready() -> void:
	hover_area.mouse_entered.connect(toggle_opened.bind(true))
	hover_area.mouse_exited.connect(toggle_opened.bind(false))
	_on_hover_area_mouse_exited()

func toggle_opened(on: bool):
	is_mouse_over = on
	if Globals.input_locked:
		await Signalbus.actions_finished
		
	opened_mesh.visible = on
	closed_mesh.visible = not on

func _on_hover_area_mouse_entered() -> void:
	if Globals.input_locked:
		await Signalbus.actions_finished
	
	if name == "PurseDiscard" and not Inventory.discard.is_empty(): #theres probably a better way to do this but idc
		discard_ui.modulate = Color(1.0, 1.0, 1.0, 1.0) #has to be modulate and not hide or show
	if name == "PurseInv" and not Inventory.current_inv.is_empty():
		inventory_ui.modulate = Color(1.0, 1.0, 1.0, 1.0)

func _on_hover_area_mouse_exited() -> void:
	
	if name == "PurseDiscard":
		discard_ui.modulate = Color(1.0, 1.0, 1.0, 0.0)
	if name == "PurseInv":
		inventory_ui.modulate = Color(1.0, 1.0, 1.0, 0.0)

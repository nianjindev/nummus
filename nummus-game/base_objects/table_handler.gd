extends Node3D
class_name Table

@onready var markers: Node3D = $Markers
@onready var endpoint_l: Marker3D = $Markers/EndpointL
@onready var endpoint_r: Marker3D = $Markers/EndpointR

var increment: float

func _ready() -> void:
	print(check_spacing(5))

func check_spacing(hand_size: int) -> Array[Vector3]:
	increment = (abs(endpoint_l.position.z) + abs(endpoint_r.position.z))/(hand_size-1)
	var positions: Array[Vector3] = []
	for i in range(hand_size):
		positions.append(endpoint_r.position + Vector3(0, 0, increment*i))
	return positions
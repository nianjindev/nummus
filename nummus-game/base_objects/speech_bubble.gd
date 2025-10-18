extends Control

@export var text_label: RichTextLabel
var dialog: Dictionary
const TEXT_SCALING: Vector2 = Vector2(24, 35)

func _ready() -> void:
	Signalbus.shop_dialog.connect(set_text)
	parse_json()

func choose_random(action: String) -> String:
	var lines = dialog[action]
	return lines.pick_random()

func set_text(action: String):
	text_label.text = choose_random(action)

func parse_json() -> void:
	# json parse
	var file = FileAccess.open(Constants.JSON_PATHS.shopkeeper, FileAccess.READ)
	assert(FileAccess.file_exists(Constants.JSON_PATHS.shopkeeper),"File doesnt exist")
	var json = file.get_as_text()
	var json_object = JSON.new()

	json_object.parse(json)
	dialog = json_object.data

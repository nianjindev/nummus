extends Control

@export var text_label: Label
@onready var timer: Timer = $LetterDisplayTimer
var dialog: Dictionary
const TEXT_SCALING: Vector2 = Vector2(24, 35)
const MAX_WIDTH: int = 216

var letter_time: float = 0.03
var space_time: float = 0.06
var puncuation_time: float = 0.2

func _ready() -> void:
	Signalbus.shop_dialog.connect(set_text)
	parse_json()

func choose_random(action: String) -> String:
	var lines = dialog[action]
	return lines.pick_random()

func set_text(action: String):
	text_label.visible_characters = -1
	text_label.text = choose_random(action)

	await resized
	
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		text_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		#custom_minimum_size.y = size.y
	size.y = 24
	global_position.x += 70 + size.x/2
	global_position.y -= size.y/2
	text_label.visible_characters = 0
	_display_letter()

func _display_letter():
	text_label.visible_characters += 1
	if text_label.visible_characters == text_label.text.length():
		Signalbus.finished_displaying.emit()
		return
	match text_label.text[text_label.visible_characters]:
		"!", ".", ",", "?":
			timer.start(puncuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)

func parse_json() -> void:
	# json parse
	var file = FileAccess.open(Constants.JSON_PATHS.shopkeeper, FileAccess.READ)
	assert(FileAccess.file_exists(Constants.JSON_PATHS.shopkeeper),"File doesnt exist")
	var json = file.get_as_text()
	var json_object = JSON.new()

	json_object.parse(json)
	dialog = json_object.data



func _on_letter_display_timer_timeout() -> void:
	_display_letter()

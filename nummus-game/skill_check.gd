extends Control
@onready var timer: Timer = $Timer
@onready var label: Label = $Label

var in_time: bool
var label_text: String = "Press Space in %s seconds"
var time: float

func _ready():
	in_time = true
	timer.start()
	time = timer.wait_time

func _process(delta: float) -> void:
	time -= 0.1*delta
	if in_time:
		print(label_text % time)
		label.text = label_text % time
		if Input.is_action_pressed("skill_check"):
			self.queue_free()

func _on_timer_timeout() -> void:
	in_time = false
	self.queue_free()

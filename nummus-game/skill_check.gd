extends Control
@onready var timer: Timer = $Timer
@onready var progress: ProgressBar = $TimerBar

var in_time: bool
var label_text: String = "Press Space in %s seconds"

func _ready():
	in_time = true
	timer.start()
	progress.value = 100

func _process(delta: float) -> void:
	if in_time:
		progress.value -= delta
		if Input.is_action_pressed("ui_accept"):
			print("good job!")
			self.queue_free()

func _on_timer_timeout() -> void:
	in_time = false
	self.queue_free()

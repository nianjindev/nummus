extends Control
@onready var timer: Timer = $Timer
@onready var progress: ProgressBar = $TimerBar

var in_time: bool

func _ready():
	in_time = true
	timer.start()

func _process(_delta: float) -> void:
	if in_time:
		progress.value = timer.time_left
		if Input.is_action_pressed("ui_accept"):
			print("good job!")
			self.queue_free()

func _on_timer_timeout() -> void:
	in_time = false
	self.queue_free()

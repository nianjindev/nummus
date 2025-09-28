extends Control
@onready var timer: Timer = $Timer
@onready var progress: TextureProgressBar = $TimerBar

var in_time: bool

func _ready():
	Signalbus.skill_check_begin.connect(start_check)
	visible = false
	in_time = false

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE and in_time:
		Signalbus.skill_check_finish.emit(true)
		in_time = false
		self.visible = false

func start_check(time: float):
	timer.wait_time = time
	progress.max_value = time
	progress.value = time
	in_time = true
	timer.start()
	self.visible = true
		

func _process(_delta: float) -> void:
	progress.value = timer.time_left
		

func _on_timer_timeout() -> void:
	in_time = false
	Signalbus.skill_check_finish.emit(false)
	self.visible = false

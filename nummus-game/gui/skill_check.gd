extends Control
@onready var timer: Timer = $Timer
@onready var progress: TextureProgressBar = $TimerBar
@onready var needle: TextureProgressBar = $Needle

var needle_speed: int
# these variables only exist because I cannot get Input to work
var diff: float
var initial_angle: float

var in_time: bool

func _ready():
	Signalbus.skill_check_begin.connect(start_check)
	visible = false
	in_time = false

func _unhandled_key_input(event: InputEvent) -> void:
	if event.pressed and event.keycode == KEY_SPACE and in_time:
		var end = diff + initial_angle
		print("When you pressed space, the needle was at %s degrees. The beginning was at %s and the end was at %s" % [needle.radial_initial_angle, initial_angle, end])
		if (needle.radial_initial_angle >= initial_angle and needle.radial_initial_angle <= end) or (needle.radial_initial_angle+360 >= initial_angle and needle.radial_initial_angle+360 <= end):
			print("YOU HIT THE NEEDLE")
			close(true)
		else:
			close(false)
		
func close(success: bool):
	in_time = false
	self.visible = false
	Signalbus.skill_check_finish.emit(success)
# difficulty is 1-360, lower = harder. speed is how fast the thingy goes. limit is how much time the user has to hit the skill check before it goes away!
func start_check(difficulty: float, speed: int, limit: float):
	diff = difficulty
	needle_speed = speed
	timer.wait_time = limit
	progress.value = difficulty
	in_time = true
	initial_angle = randi()%360
	progress.radial_initial_angle = initial_angle # generates a random angle for the thing to spawn in
	timer.start()
	self.visible = true
		

func _process(delta: float) -> void:
	needle.radial_initial_angle += needle_speed*delta
	needle.radial_initial_angle = fmod(needle.radial_initial_angle,360)
		

func _on_timer_timeout() -> void:
	close(false)

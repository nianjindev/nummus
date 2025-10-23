extends Node3D

@onready var sprite: AnimatedSprite3D = $AnimatedSprite3D
var speech_bubble_3d: Node3D
@onready var timer: Timer = $IntervalTimer

var idle_interval: float = 15.0
var bubble_alive: float = 3.0

func _ready() -> void:
	Signalbus.finished_displaying.connect(hide_bubble)
	display_idle.call_deferred()

func hide_bubble():
	timer.start(bubble_alive)
	await timer.timeout
	speech_bubble_3d.queue_free()
	display_idle()
	

func display_idle():
	timer.start(idle_interval)
	await timer.timeout
	speech_bubble_3d = ResourceLoader.load(Constants.SCENE_PATHS.speech_bubble).instantiate()
	sprite.add_child(speech_bubble_3d)
	Signalbus.shop_dialog.emit("idle")
	

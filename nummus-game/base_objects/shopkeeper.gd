extends Node3D

@onready var speech_bubble_3d: Node3D = $AnimatedSprite3D/SpeechBubble3D
@onready var text_label = speech_bubble_3d.speech_bubble_gui.text_label
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.start()



func _on_timer_timeout() -> void:
	Signalbus.shop_dialog.emit("idle")
	timer.start()

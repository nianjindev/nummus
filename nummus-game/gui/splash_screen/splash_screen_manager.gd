extends Control

@export var in_time: float = 0.5
@export var fade_in_time: float = 1.5
@export var pause_time: float = 2
@export var fade_out_time: float = 1.5
@export var out_time: float = 0.5
@export var splash_screen_container: Node

var main_menu: String = Constants.UI_PATHS.main_menu

var splash_screens: Array


func _ready():
	get_screens()
	fade()

func get_screens():
	splash_screens = splash_screen_container.get_children()
	for screen in splash_screens:
		screen.modulate.a = 0.0
		

func fade():
	for screen in splash_screens:
		var tween = get_tree().create_tween()
		tween.tween_interval(in_time)
		tween.tween_property(screen, "modulate:a", 1.0, fade_in_time)
		tween.tween_interval(pause_time)
		tween.tween_property(screen, "modulate:a", 0.0, fade_out_time)
		tween.tween_interval(out_time)
		await tween.finished
	SceneManager.goto_scene(main_menu)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		SceneManager.goto_scene(main_menu)

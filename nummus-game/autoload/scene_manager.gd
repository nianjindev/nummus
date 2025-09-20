extends Node

var current_scene = null

func _ready():
	var root = get_tree().root
	# Using a negative index counts from the end, so this gets the last child node of `root`.
	current_scene = root.get_child(-1)

func _deferred_goto_scene(path):
	current_scene.free()
	
	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

func goto_scene(path):
	_deferred_goto_scene.call_deferred(path)

func _deferred_add_scene(path):
	# make sure it frees itself after its done
	var new_scene = ResourceLoader.load(path).instantiate()
	get_tree().root.add_child(new_scene)

func add_scene(path):
	_deferred_add_scene.call_deferred(path)


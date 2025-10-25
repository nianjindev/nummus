extends Node3D

class_name Enemy

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health_text: Label3D = $EnemySprite/HealthText
@export var enemy_id: EnemyStats
@onready var animated_sprite: AnimatedSprite3D = $EnemySprite

# Stats
var max_health: int
var health: int
var period: int
var moves: Dictionary
var enemy_json_id: String

# Animation values
var hurt_small_length: float = 0.5
var hurt_medium_length: float = 1
var death_length: float = 3.0

# period system
var current_period: int = 0


func _ready():
	Signalbus.change_enemy_health.connect(change_health)
	Signalbus.enemy_visuals.connect(on_enemy_visuals_played)
	Signalbus.increase_period.connect(increase_p)

	# Init resource
	animated_sprite.sprite_frames = enemy_id.enemy_expressions
	enemy_json_id = enemy_id.json_id
	parse_json()

	animated_sprite.play("neutral")
	health_text.text = str(health as int)+"/" + str(max_health)
	# transform
	position = Vector3(-1.604,1,0.0)
	rotate_y(PI/2)
	scale = Vector3(0.6,0.6,0.6)
	
func increase_p(inc: int):
	if current_period >= period:
		current_period %= period
		do_move()
	current_period += inc

func do_move():
	var weights: Array[float] = []
	for move in moves:
		weights.append(1/moves.get(move).get("weight"))
	var move = moves.keys().get(SeedManager.rng.rand_weighted(weights))
	match move:
		"attack":
			Signalbus.change_health_and_update_ui.emit(true, -moves.get(move).get("damage"), true)
		"heal":
			change_health(true, 3)
		"poison":
			print("lol we are never getting here")
	

func parse_json() -> void:
	# json parse
	var json_object = ObjectManager.parse_json(Constants.JSON_PATHS.enemies)
	for enemy in json_object.data:
		if enemy == enemy_json_id:
			max_health = json_object.data.get(enemy).get("health")
			health = max_health
			period = json_object.data.get(enemy).get("period")
			moves = json_object.data.get(enemy).get("moves")
			
func play_hurt_animation():
	animated_sprite.play("hurt")
	animation_player.speed_scale = 0
	
	await get_tree().create_timer(hurt_small_length).timeout
	
	animated_sprite.play("neutral")
	animation_player.speed_scale = 1
	
	GuiManager.toggle_coin_flip_ui.emit(true)

func play_death_animation():
	animated_sprite.play("very_hurt")
	animation_player.speed_scale = 0
	GuiManager.toggle_coin_flip_ui.emit(false)

	await get_tree().create_timer(death_length).timeout
	
	Signalbus.current_enemy_defeated.emit()

func take_damage(amount: int):
	if health + amount < 0 or health + amount == 0:
		health = 0
		Signalbus.enemy_visuals.emit("death")
	else:
		health += amount
		Signalbus.enemy_visuals.emit("hurt")

func heal(amount: int):
	health += amount

func change_health(add: bool, amount: int):
	if add:
		if amount < 0:
			take_damage(amount)
		else:
			heal(amount)
	else:
		if amount < health:
			take_damage(amount - health)
		else:
			heal(health - amount)
	health_text.text = str(health as int)+"/" + str(max_health)
func on_enemy_visuals_played(visual: String):
	match visual:
		"none":
			print("NONE")
			GuiManager.toggle_coin_flip_ui.emit(true)
		"death":
			play_death_animation()
		"hurt":
			play_hurt_animation()

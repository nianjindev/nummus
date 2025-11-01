extends Node3D

class_name Enemy

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health_text: Label3D = $EnemySprite/HealthText
@onready var period_text: Label3D = $EnemySprite/PeriodText
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
var death_length: float = 5

# period system
var current_period: int = 0



func _ready():
	Signalbus.change_enemy_health.connect(change_health)
	Signalbus.increase_period.connect(increase_p)
	# Init resource
	animated_sprite.sprite_frames = enemy_id.enemy_expressions
	enemy_json_id = enemy_id.json_id
	parse_json()
	# Init UI
	#animated_sprite.play("neutral")
	GuiManager.update_period_text.emit(current_period)
	GuiManager.update_enemy_health_text.emit(health, max_health)
	# transform
	position = Vector3(-1.604,1,0.0)
	rotate_y(PI/2)
	scale = Vector3(0.6,0.6,0.6)
	
func increase_p(inc: int):
	if current_period >= period:
		current_period %= period
		do_move()
	current_period += inc
	GuiManager.update_period_text.emit(current_period)
	GuiManager.update_enemy_health_text.emit(health, max_health)

func do_move():
	var weights: Array[float] = []
	for move in moves:
		weights.append(1/moves.get(move).get("weight"))
	weights=[1,0,0]
	var move = moves.keys().get(SeedManager.rng.rand_weighted(weights))
	match move:
		"attack":
			animation_player.play(enemy_json_id + "/" + move)
		"heal":
			change_health(true, moves.get(move).get("heal"))
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
	animation_player.play(enemy_json_id + "/hurt")
	await animation_player.animation_finished
	GuiManager.toggle_coin_flip_ui.emit(true)

func play_death_animation():
	animation_player.play(enemy_json_id + "/death")
	GuiManager.toggle_coin_flip_ui.emit(false)

	await animation_player.animation_finished
	
	Signalbus.current_enemy_defeated.emit()

func take_damage(amount: int):
	if health + amount < 0 or health + amount == 0:
		health = 0
		play_death_animation()
	else:
		health += amount
		play_hurt_animation()

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

func deal_damage(add: bool, amount: int):
	Globals.change_player_health(add, amount)

func trigger_camera_shake(max: float, fade: float):
	Signalbus.trigger_camera_shake.emit(max, fade)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_player.play(enemy_json_id + "/idle")

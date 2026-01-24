extends TextureProgressBar

@onready var heads_percent: Label = $HeadsPercent
@onready var tails_percent: Label = $TailsPercent
@onready var chance_o_meter: TextureProgressBar = $"."

func _ready():
	GuiManager.run_chance_wheel.connect(on_wheel_ran)
	GuiManager.update_chance_wheel.connect(update_wheel)

func update_percentage(heads: int, tails: int):
	heads_percent.text = str(heads) + "%"
	tails_percent.text = str(tails) + "%"

func update_wheel(heads: float, tails: float):
	var int_heads = int(round(heads * 100))
	var tail_heads = int(round(tails * 100))
	
	update_percentage(int_heads, tail_heads)
	chance_o_meter.value = int_heads
	
func on_wheel_ran():
	update_wheel(Globals.head_weight, Globals.tail_weight)
	await get_tree().create_timer(0.5).timeout
	
	RecursiveEffect.run_weight_effects()
	await RecursiveEffect.run_weight_effects()
	
	Globals.action_finished()

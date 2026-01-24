extends TextureProgressBar

@onready var heads_percent: Label = $HeadsPercent
@onready var tails_percent: Label = $TailsPercent
@onready var chance_o_meter: TextureProgressBar = $"."

func _ready():
	GuiManager.update_chance_wheel.connect(on_chance_wheel_updated)

func on_chance_wheel_updated(heads: float, tails: float):
	var int_heads = int(round(heads * 100))
	var tail_heads = int(round(tails * 100))
	
	update_percentage(int_heads, tail_heads)
	chance_o_meter.value = int_heads
	
func update_percentage(heads: int, tails: int):
	heads_percent.text = str(heads) + "%"
	tails_percent.text = str(tails) + "%"

extends TextureRect

@onready var heads_percent: Label = $HeadsPercent
@onready var tails_percent: Label = $TailsPercent

func _ready():
	GuiManager.update_chance_wheel.connect(update_percentage)
	print("ASDASDASD")

func update_percentage(heads: float, tails: float):
	heads_percent.text = str(int(round(heads * 100))) + "%"
	tails_percent.text = str(int(round(tails * 100))) + "%"

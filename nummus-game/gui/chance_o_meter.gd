extends TextureRect

@onready var heads_percent: Label = $HeadsPercent
@onready var tails_percent: Label = $TailsPercent

func _ready():
	GuiManager.update_chance_wheel.connect(update_percentage)
	print("ASDASDASD")

func update_percentage(heads: String, tails: String):
	heads_percent.text = heads
	tails_percent.text = tails

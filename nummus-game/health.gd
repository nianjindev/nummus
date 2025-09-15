extends Control

@onready var progress_bar: ProgressBar = $ProgressBar

func _ready():
	Globals.connect("money_changed", change_amount())
	progress_bar.value = Globals.health

func change_amount():
	progress_bar.value = Globals.health

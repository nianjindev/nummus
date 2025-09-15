extends Control

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var health_text: RichTextLabel = $HealthText

func _ready():
	Globals.connect("money_changed", Callable(change_amount))
	progress_bar.value = Globals.health
	health_text.text = str(Globals.health as int)+"/20"

func change_amount():
	progress_bar.value = Globals.health
	health_text.text = str(Globals.health as int)+"/20"

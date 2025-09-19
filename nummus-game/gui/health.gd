extends Control

@onready var health_progress_bar: TextureProgressBar = $HealthProgressBar
@onready var health_text: RichTextLabel = $HealthText


func _ready():
	Globals.connect("money_changed", Callable(change_amount))
	health_progress_bar.value = Globals.health
	health_text.text = str(Globals.health as int)+"/20"

func change_amount():
	health_progress_bar.value = Globals.health
	health_text.text = str(Globals.health as int)+"/20"

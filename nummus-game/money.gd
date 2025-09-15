extends Control

@onready var amount: RichTextLabel = $Amount

func _ready():
	Globals.connect("money_changed", Callable(change_amount))
	amount.text = "$" + str(Globals.money)
	

func change_amount():
	amount.text = "$" + str(Globals.money)

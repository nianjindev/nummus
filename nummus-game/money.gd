extends Control

@onready var amount: RichTextLabel = $Amount

func _ready():
	Globals.connect("money_changed", change_amount())
	amount.text = "$" + String(Globals.money)
	

func change_amount():
	amount.text = "$" + String(Globals.money)

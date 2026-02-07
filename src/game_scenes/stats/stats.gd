extends Control

###---Nodes---###
@onready var label_1: Label = $VBoxContainer/HBoxContainer/Label1
@onready var label_2: Label = $VBoxContainer/HBoxContainer/Label2

###---Variables---###
var label1_innit_text:String
var label2_innit_text:String

# Called when the node enters the scene tree for the first time.
func _ready():
	label1_innit_text = label_1.text
	
	Player.money_change.connect(_on_money_changed)
	Player.organ_added.connect(_refresh_organ)
	Player.organ_removed.connect(_refresh_organ)

	refresh()

func refresh():
	label_1.text = label1_innit_text
	label_1.text = $Label.text.replace("$wave", str(GameData.wave))
	label_1.text = $Label.text.replace("$COINS_TOSSED", str(Player.get_attribute(Player.Attributes.COINS_TOSSED)))
	label_1.text = $Label.text.replace("$Money", str(Player.money)) 
	
	_on_money_changed()
	_refresh_organ()

func _on_money_changed()->void:
	refresh()

func _refresh_organ()->void:
	refresh()

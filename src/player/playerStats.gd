extends Control

var init_organ_text:String
var init_attributes_text:String

# Called when the node enters the scene tree for the first time.
func _ready():
	
	init_attributes_text = "Money : $money"
	init_organ_text = "Organes :"
	
	Player.money_change.connect(_on_money_changed)
	Player.organ_added.connect(_refresh_organ)
	Player.organ_removed.connect(_refresh_organ)

	refresh()

func refresh():
	_on_money_changed()
	_refresh_organ()

func _on_money_changed()->void:
	$Label2.text = $Label2.text.replace("$Money", Player.money)

func _refresh_organ()->void:
	$Label1.text = init_organ_text
	for organ in Player.organs:
		$Label1.text += organ.name

@abstract class_name ShopItem extends Control

#texte du boutton
var text:String = "Default"
#lignes de tooltip
var tooltip1:String = ""
var tooltip2:String = ""
var tooltip3:String = ""

@export var cost:float = 0:
	set(new_cost):
		cost = new_cost
		cost_change.emit(cost)
	get(): 
		return cost

signal cost_change

func _ready():
	$Button.pressed.connect(try_to_buy)
	cost_change.connect(load_cost)

func load_cost(new_cost:float) -> void:
	tooltip3 = str(new_cost) + "$"
	$Button.tooltip_text = "{0}\n{1}\n{2}".format([tooltip1, tooltip2, tooltip3])

func try_to_buy() -> void:
	if Player.money >= cost:
		Player.set("money", Player.get("money") - cost)
		bought()

func bought():
	cost = 0

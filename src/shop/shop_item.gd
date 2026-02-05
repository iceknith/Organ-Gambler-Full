class_name ShopItem extends Control

var item:Organ
var cost:float

signal buy()

func _ready():
	pass


func load_organ(organ:Organ, price:float) -> void:
	item = organ
	cost = price
	#$Button.icon = load(Organ.picture)
	$Button.text = item.name
	$Button.tooltip_text = "%s\n%s\n%s".format([item.name, item.description, price])


func _on_button_pressed() -> void:
	buy.emit()
	pass # Replace with function body.

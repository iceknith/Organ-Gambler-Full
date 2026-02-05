@abstract class_name ShopItem extends Control


@export var cost:float

signal try_to_buy()

func _ready():
	#$Button.pressed().connect(try_to_buy)
	
	#visible = false
	pass


func load_item(price:float) -> void:
	cost = price

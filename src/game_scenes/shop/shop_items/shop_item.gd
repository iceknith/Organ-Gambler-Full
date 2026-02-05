@abstract class_name ShopItem extends Control


@export var cost:float


func _ready():
	
	visible = true
	pass


func load_price(price:float) -> void:
	cost = price

func buy() -> void:
	pass

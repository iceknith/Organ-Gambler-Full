class_name Shop extends Control

@export var organs_inventory_size:int = 6
var organs_inventory:Array[Organ]
var organs_inventory_price:Array[float]

@export var coins_inventory_size:int = 6
var coins_inventory:Array[Coin]
var coins_inventory_price:Array[float]

func _ready():
	restock()

func restock():
	restock_organs()

func restock_organs() -> void:
	organs_inventory.clear()
	for i in range(organs_inventory_size):
		organs_inventory.append(OrganLoader.get_random_object())
		print(organs_inventory[i])
		#price = base + nb d'achat + wave




func calculate_price_organs(index:int) -> float:
	return 0

func calculate_price_coin(index:int) -> float:
	return 0

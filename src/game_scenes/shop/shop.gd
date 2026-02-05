class_name Shop extends Control

@export var price_multiplier:float = 1
@export var flat_price_increase:float = 0
var items_bought:int = 0

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
	restock_coins()

func restock_organs() -> void:
	
	organs_inventory.clear()
	organs_inventory_price.clear()
	var current_organ:Organ
	
	for index in range(organs_inventory_size):
		#séléction d'un organe et calcul du prix
		current_organ = OrganLoader.get_random_object()
		organs_inventory.append(current_organ)
		organs_inventory_price.append(calculate_price_organ(index))

		print("slot {0}: {1} {2}$".format([index, organs_inventory[index], str(organs_inventory_price[index])]))

func restock_coins() -> void:
	
	coins_inventory.clear()
	coins_inventory_price.clear()
	var current_coin:Coin
	
	for index in range(coins_inventory_size):
		#séléction d'un coin et calcul du prix
		current_coin = CoinLoader.get_random_object()
		coins_inventory.append(current_coin)

		coins_inventory_price.append(calculate_price_coin(index))

		print("slot {0}: {1} {2}$".format([index, coins_inventory[index], str(coins_inventory_price[index])]))

func calculate_price_organ(index:int) -> float:
	var base:float = organs_inventory[index].base_cost
	var wave:int = GameData.wave
	var bought:int = items_bought
	var price:float = base + (2 + base * bought) * max(0, wave - 3)
	price = (price + flat_price_increase) * price_multiplier 
	return price

func calculate_price_coin(index:int) -> float:
	var base:float = coins_inventory[index].base_cost
	var wave:int = GameData.wave
	var bought:int = items_bought
	var price:float = base + (2 + base * bought) * max(0, wave - 3)
	price = (price + flat_price_increase) * price_multiplier 
	return price

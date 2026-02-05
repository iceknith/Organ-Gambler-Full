class_name Shop extends Control

@export var price_multiplier:float = 1
@export var flat_price_increase:float = 0
var items_bought:int = 0

@export var organs_inventory_size:int = 6
var organs_inventory:Array[ShopItemOrgan]

@export var coins_inventory_size:int = 6
var coins_inventory:Array[Coin]
var coins_inventory_price:Array[float]

@onready var shop_organ_scene:PackedScene = preload("res://src/game_scenes/shop/shop_items/shopItemOrgan.tscn")


func _ready():
	load_shop()
	restock()

func load_shop() -> void:
	print("hey")
	var shop_instance:Node
	
	for index in range(organs_inventory_size):
		shop_instance = shop_organ_scene.instantiate()
		print(shop_instance)
		$OrganContainer.add_child(shop_instance)
		organs_inventory.append(shop_instance)
	
	print(organs_inventory)


func restock():
	restock_organs()
	restock_coins()

func restock_organs() -> void:
	
#	var shop_item:ShopItemOrgan
	var current_organ:Organ
	
	for index in range(organs_inventory_size):
		#séléction d'un organe et calcul du prix
		#shop_item = organs_inventory[index]
		current_organ = OrganLoader.get_random_object()
		#shop_item.load_organ(current_organ,calculate_price_organ(current_organ))

		#print("slot {0}: {1} {2}$".format([index, organs_inventory[index].item, organs_inventory[index].cost]))

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

func calculate_price_organ(organ:Organ) -> float:
	var base:float = organ.base_cost
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

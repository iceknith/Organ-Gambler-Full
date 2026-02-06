class_name Shop extends Control

@export var cost_multiplier:float = 1
@export var flat_cost_increase:float = 0
@export var reroll_left:int = 3

#total sur toute la partie
var items_bought:int = 0
var reroll:int = 0

@export var organs_inventory_size:int = 6
var organs_inventory:Array[ShopItemOrgan]

@export var coins_inventory_size:int = 6
var coins_inventory:Array[ShopItemCoin]

@onready var shop_organ_scene:PackedScene = preload("res://src/game_scenes/shop/shop_items/shopItemOrgan.tscn")
@onready var shop_coin_scene:PackedScene = preload("res://src/game_scenes/shop/shop_items/shopItemCoin.tscn")

func _ready():
	load_shop()
	$ItemContainer/RerollButton.pressed.connect(reroll_shop)
	restock()

func load_shop() -> void:
	var shop_instance:Control
	
	for index in range(organs_inventory_size):
		shop_instance = shop_organ_scene.instantiate()
		$ItemContainer/OrganContainer.add_child(shop_instance)
		shop_instance.show()
		organs_inventory.append(shop_instance)
		
	for index in range(coins_inventory_size):
		shop_instance = shop_coin_scene.instantiate()
		$ItemContainer/CoinContainer.add_child(shop_instance)
		shop_instance.show()
		coins_inventory.append(shop_instance)


func restock():
	restock_all_organs()
	restock_all_coins()

func restock_all_organs() -> void:
	
	for index in range(organs_inventory_size):
		restock_organ(index)

func restock_organ(index:int) -> void:
	var shop_item:ShopItemOrgan
	var random_organ:Organ
	var cost:float

	#séléction d'un organe et calcul du prix
	shop_item = organs_inventory[index]
	random_organ = OrganLoader.get_random_object()
	cost = calculate_cost_organ(random_organ)
	shop_item.set("organ", random_organ)
	shop_item.set("cost", cost)
	
	print("{0} {1} {2}$\n".format([random_organ.name,random_organ.description,cost]))

func restock_all_coins() -> void:
	
	for index in range(coins_inventory_size):
		restock_coin(index)

func restock_coin(index:int) -> void:
	var shop_item:ShopItemCoin
	var random_coin:Coin
	var cost:float

	#séléction d'un coin et calcul du prix
	shop_item = coins_inventory[index]
	random_coin = CoinLoader.get_random_object()
	cost = calculate_cost_coin(random_coin)
	shop_item.set("coin", random_coin)
	shop_item.set("cost", cost)
	
	print("{0} {1} {2}$\n".format([random_coin.name,random_coin.description,cost]))

func calculate_cost_organ(organ:Organ) -> float:
	var base:float = organ.base_cost
	var wave:int = GameData.wave
	var bought:int = items_bought
	var cost:float = base + (2 + base * bought) * max(0, wave - 3)
	cost = (cost + flat_cost_increase) * cost_multiplier 
	return cost

func calculate_cost_coin(coin:Coin) -> float:
	var base:float = coin.base_cost
	var wave:int = GameData.wave
	var bought:int = items_bought
	var cost:float = base + (2 + base * bought) * max(0, wave - 3)
	cost = (cost + flat_cost_increase) * cost_multiplier 
	return cost
	
func reroll_shop():
	if reroll_left > 0:
		reroll_left -= 1
		reroll += 1
		restock()

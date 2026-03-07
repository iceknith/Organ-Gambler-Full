class_name Shop extends Control

@export var cost_multiplier:float = 1
@export var flat_cost_increase:float = 0
var reroll_left:int
var reroll_used:int
var player_reroll:float

#total sur toute la partie
var total_items_bought:int = 0
var total_reroll:int = 0

@export var organs_inventory_size:int = 6
var organs_inventory:Array[ShopItemOrgan]

@export var coins_inventory_size:int = 6
var coins_inventory:Array[ShopItemCoin]

@onready var shop_organ_scene:PackedScene = preload("res://src/game_scenes/shop/shop_items/shopItemOrgan.tscn")
@onready var shop_coin_scene:PackedScene = preload("res://src/game_scenes/shop/shop_items/ShopItemCoin.tscn")

func _ready() -> void:
	connect_signals()
	
	load_shop()
	$ItemContainer/RerollButton.pressed.connect(reroll_shop)
	restock()
	
	player_reroll = Player.get_attribute(Player.Attributes.SHOP_REROLL)
	reroll_left = player_reroll
	reroll_used = 0

func connect_signals() -> void:
	# Connect button signals
	$Back.pressed.connect(Main.main.go_back)
	$Stats.pressed.connect(Main.main.switch_to_scene.bind("stats"))

func load_shop() -> void:
	var shop_instance:ShopItem
	
	for index in range(organs_inventory_size):
		shop_instance = shop_organ_scene.instantiate()
		$ItemContainer/OrganContainer.add_child(shop_instance)
		shop_instance.show()
		organs_inventory.append(shop_instance)
		shop_instance.item_bought.connect(_on_item_bought)
		
	for index in range(coins_inventory_size):
		shop_instance = shop_coin_scene.instantiate()
		$ItemContainer/CoinContainer.add_child(shop_instance)
		shop_instance.show()
		coins_inventory.append(shop_instance)
		shop_instance.item_bought.connect(_on_item_bought)

func restock() -> void:
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
	var bought:int = total_items_bought
	var cost:float = base + (2 + base * bought) * max(0, wave - 3)
	cost = (cost + flat_cost_increase) * cost_multiplier 
	return cost

func calculate_cost_coin(coin:Coin) -> float:
	var base:float = coin.base_cost
	var wave:int = GameData.wave
	var bought:int = total_items_bought
	var cost:float = base + (2 + base * bought) * max(0, wave - 3)
	cost = (cost + flat_cost_increase) * cost_multiplier 
	return cost

func reroll_shop() -> void:
	if reroll_left > 0:
		reroll_left -= 1
		total_reroll += 1
		reroll_used += 1
		restock()

func update_reroll() -> void:
	player_reroll = Player.get_attribute(Player.Attributes.SHOP_REROLL)
	reroll_left = player_reroll - reroll_used
	print(reroll_left)


func _on_item_bought() -> void:
	update_reroll.call_deferred()
	pass

#reroll update
#add reroll_used and recalculate reroll_left = player_reroll - reroll_used
#_on_bought

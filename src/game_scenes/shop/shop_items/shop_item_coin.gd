class_name ShopItemCoin extends ShopItem

signal coin_change

@export var coin:Coin = null:
	set(new_coin):
		coin = new_coin
		coin_change.emit(coin)
	get(): 
		return coin

func _ready():
	super._ready()
	
	coin_change.connect(load_coin)

func load_coin(new_coin:Coin) -> void:
	
	if new_coin != null:
		#$Button.icon = coin.picture
		$Button.text = new_coin.name
		tooltip1 = new_coin.name
		tooltip2 = new_coin.description
	else:
		tooltip1 = ""
		tooltip2 = ""
		$Button.text = "empty"
	$Button.tooltip_text = "{0}\n{1}\n{2}".format([tooltip1, tooltip2, tooltip3])


func try_to_buy() -> void:
	#super.try_to_buy seulement si l'inventaire de coin n'est pas plein
	if Player.get_total_coin_count() < Player.maxCoinCount:
		super.try_to_buy()
	else:
		printerr("Inventaire de coin plein")

func bought():
	super.bought()
	#ajout du coin à l'inventaire
	Player.add_coin(coin)
	set("coin",null)
	pass

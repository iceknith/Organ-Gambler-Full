class_name CoinSlot extends Button

var index:int

signal select
signal coin_change

@export var coin:Coin = null:
	set(new_coin):
		coin = new_coin
		coin_change.emit(coin)
	get(): 
		return coin

func _ready() -> void:
	Player.coin_added.connect(refresh)
	Player.coin_removed.connect(refresh)
	pass

func refresh() -> void:
	coin = Player.coins[index]
	if coin != null:
		text = coin.name
		tooltip_text = "{0}\n{1}\n{2}".format([coin.name,coin.description,coin.durability])
		disabled = false
	else:
		text = "Empty"
		tooltip_text = ""
		disabled = true
		
func _pressed() -> void:
	if coin:
		Player.selectedCoinIndex = index
		select.emit(self)

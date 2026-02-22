class_name CoinSlot extends Button

var index:int

signal select
signal coin_change
signal try_to_delete

@export var coin:Coin = null:
	set(new_coin):
		coin = new_coin
		coin_change.emit(coin)
	get(): 
		return coin

func _ready() -> void:
	
	Player.coin_added.connect(refresh)
	Player.coin_removed.connect(refresh)
	$Delete.pressed.connect(_on_delete_pressed)
	
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
		$Delete.visible = true
		select.emit(self)

func _on_delete_pressed() -> void:
	print("Sure ?")
	try_to_delete.emit()

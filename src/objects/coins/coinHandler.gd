class_name coinHandler extends RefCounted
#Instantiate and manages the coins.


func playHands() -> float:
	#  Player.coins[0] is choosen to be the current coin 
	# TODO implementer current_coin dans player 
	var current_coint = Player.coins[0]
	var outcome:float = 0
	
	# cree un objet coin, je l'instanceie (packed scene) --> connecter a tt les trucs 
	var random = RandomNumberGenerator.new()
	for coin in Player.get_attribute(Player.Attributes.COINS_TOSSED):
	# Evaluate the outcome of the current coin
		var coin_tossed_luck = current_coint.luck + Player.get_attribute(Player.Attributes.LUCK)
		
		if(coin_tossed_luck > random.randf_range(0.0,100.0)):
			outcome += current_coint._on_tails()
		else:
			outcome += current_coint._on_heads()
		
		#coin instantiation
		var pos_x= random.randi_range(0,ProjectSettings.get_setting("display/window/size/viewport_width"))
		var pos_y = random.randi_range(0,ProjectSettings.get_setting("display/window/size/viewport_height"))
		spawn_coin(current_coint,Vector2(pos_x,pos_y))
	
	#subtracts durability
	current_coint.durability-=1
	
	return outcome;

func spawn_coin(coin_data:Coin, spawn_position:Vector2)->void:
	pass

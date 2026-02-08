class_name CoinHandler extends Node2D
#Instantiate and manages the coins.

# Screen limits & offsets
var window_height = ProjectSettings.get_setting("display/window/size/viewport_height")
var window_width = ProjectSettings.get_setting("display/window/size/viewport_width")

var offset_spawn_x:Vector2 = Vector2(50, -50)
var offset_spawn_y:Vector2 = Vector2(50, -50)

# Coins
var coins_to_toss:int
var coins_landed:int

var total_outcome:float

func _ready() -> void:
	# COMMENT RECUPERER LE SIGNAL DES PIECES QUI SONT INSTANCIEES?
	#coinVisual.landed.connect(coin_landed)
	pass

func playHands() -> float:
	#  Player.coins[0] is choosen to be the current coin 
	# TODO implement current_coin 
	var current_coint = Player.coins[0]
	var outcome:float = 0
	coins_to_toss = Player.get_attribute(Player.Attributes.COINS_TOSSED)
	
	for coin in coins_to_toss:

		var random = RandomNumberGenerator.new()
		var pos_x= random.randi_range(offset_spawn_x[0],window_width+offset_spawn_x[1])
		var pos_y = random.randi_range(offset_spawn_y[0],window_height+offset_spawn_y[1])
		spawn_coin(current_coint,Vector2(pos_x,pos_y))
	
	#subtracts durability
	current_coint.durability-=1
	
	return outcome;

#Instantiate coin
func spawn_coin(coin_data:Coin, spawn_position:Vector2)->void:
	#cree la scene a partir de coinVisual 
	
	# donne les infos de currents coin a la scene
	
	# On l'ajoute à l'arbre
	
	pass

func coin_landed() -> void:
	coins_landed +=1
	#coins_to_toss+= . . .
	if coins_landed >=coins_to_toss:
		pass

class_name coinHandler extends Node2D

###---Signals---#
signal hands_finished()

###---Variables---###
# coin
const coin_scene: PackedScene = preload("res://src/objects/coins/visual_coin/coinVisual.tscn")

var nb_coins_to_toss:int
var nb_coins_landed:int
var total_outcome:float

var current_coin:Coin

@export_group("instanciation & game speed")
@export var delay_before_changing_scene:float = 3
@export var spawn_delay:float = 0.5
@export var speed_scale:float = 0.2

# hand 
const hand_scene:PackedScene = preload("res://src/objects/coins/visual_hand/handVisual.tscn")

# spawn position
@export_group("Screen limits & offsets")
var window_height = ProjectSettings.get_setting("display/window/size/viewport_height")
var window_width = ProjectSettings.get_setting("display/window/size/viewport_width")
@export var offset_spawn_x:Vector2 = Vector2(100, -100)
@export var offset_spawn_y:Vector2 = Vector2(100, -300)

###---Functions---###
func playHands() -> void:
	#print("-Round started - playing hands... --------------------------------------")
	
	current_coin = Player.coins[Player.selectedCoinIndex]
	#print("Slected coin :"+current_coin.name)
	
	# Reset coinHandler's data
	total_outcome = 0
	nb_coins_landed = 0
	
	# Retrieve every organ that can toss a coin
	var player_hands:Array[Organ]
	for organ in Player.organs:
		if organ.modifiers.any(func(attribut): return attribut.type == Player.Attributes.COINS_TOSSED):
			player_hands.append(organ)
	player_hands.shuffle()
	nb_coins_to_toss =player_hands.size()
	var spawn_delay_speed = clamp(speed_scale*nb_coins_to_toss,1,5)
	
	for i in range(nb_coins_to_toss):
		#debug
		#print("Coin" + str(current_coin.name)+" instantiated, lauched with hand type "+ str(player_hands[i].name))
		player_hands[i]._on_used()

		var landing_position =  get_random_position()
		spawn_coin(current_coin,landing_position)
		spawn_hand(player_hands[i],landing_position)
		await get_tree().create_timer(spawn_delay/spawn_delay_speed).timeout	
	
	#subtracts durability
	current_coin.durability-=1

func spawn_coin(coin_data:Coin, spawn_position:Vector2)->void:
	var coin = coin_scene.instantiate()

	coin.coin_data = coin_data
	coin.player_luck = Player.get_attribute(Player.Attributes.LUCK)
	coin.landing_position = spawn_position

	coin.landed.connect(coin_landed)

	add_child(coin)

func spawn_hand(hand_data:Organ, spawn_position:Vector2)->void:
	var hand = hand_scene.instantiate()

	hand.hand_data = hand_data
	hand.landing_position = spawn_position

	add_child(hand)

func coin_landed(outcome:float) -> void:
	#print("Coin" + str(current_coin.name)+" landed, value =", str(outcome) )
	
	nb_coins_landed +=1
	total_outcome += outcome 

	if nb_coins_landed == nb_coins_to_toss:
		end_round()
	

func end_round() -> void:
	if current_coin.durability == 0:
		current_coin._on_broke()
	
	#debug
	#print("Total outcome: "+ str(total_outcome))
	#print("-Round ended - deleting hands & coins... -------------------------------")

	await get_tree().create_timer(delay_before_changing_scene).timeout
	hands_finished.emit()
	await get_tree().create_timer(1).timeout
	
	clean_scene()

func clean_scene() -> void:
	for child in get_children():
		child.queue_free()

func get_random_position()->Vector2:
	var random = RandomNumberGenerator.new()
	var pos_x= random.randf_range(offset_spawn_x[0],window_width+offset_spawn_x[1])
	var pos_y = random.randf_range(offset_spawn_y[0],window_height+offset_spawn_y[1])
	return Vector2(pos_x,pos_y)

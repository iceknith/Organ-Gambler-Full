class_name coinVisual extends Node2D 



###---Signals---#
signal landed(result: float)

###---Variables---###

var coin_data:Coin 
var player_luck:float
var landing_position:Vector2

var positionFinale:Vector2
var positionInit:Vector2

var outcome:float = 0

###---Functions---###

func _ready() -> void:
	update_visuals()
	flip()

func update_visuals() -> void:
	if(!coin_data.texture):
		print("waring: missing coin texture")
	else: get_child(0).Texture2D = coin_data.texture

func flip() ->void:
	
	coin_data._on_tossed()
	
	animation_and_mouvement()
	
	coin_data._on_landed()

	var current_luck = player_luck / ( player_luck + 1/coin_data.luck - 1)
	if(current_luck > RandomNumberGenerator.new().randf_range(0.0,1.0)):
		outcome =  coin_data._on_tails()
	else:
		outcome =  coin_data._on_heads()
		
	Player.money+=outcome
	landed.emit(outcome)

func animation_and_mouvement()-> void:
	# play the coin's animation
	# $AnimationPlayer.play("spin") 
	# await $AnimationPlayer.animation_finished
	position = landing_position

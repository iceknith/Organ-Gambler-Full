class_name coinVisual extends Node2D 

###---Signals---#
signal landed(result: float)

###---Variables---###

var coin_data:Coin 
var player_luck:float
var landing_position:Vector2

###---Functions---###

func _ready() -> void:
	update_visuals()
	flip()

func update_visuals():
	pass

func flip():
	var outcome:float = 0
	
	coin_data._on_tossed()
	
	animation()
	
	coin_data._on_landed()

	 
	var current_luck = player_luck / ( player_luck + 1/coin_data.luck - 1)
	
	if(current_luck > RandomNumberGenerator.new().randf_range(0.0,1.0)):
		outcome =  coin_data._on_tails()
	else:
		outcome =  coin_data._on_heads()
		
	landed.emit(outcome)

func animation()-> void:
	# play the coin's animation
	# $AnimationPlayer.play("spin") 
	# await $AnimationPlayer.animation_finished
	pass

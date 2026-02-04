extends Node2D 

# Signal attendu par coinHandler
signal landed(result: float)

var coin_data:Coin 


func _ready() -> void:
	update_visuals()
	flip()

func update_visuals():
	pass

func flip():
	var outcome:float = 0
	
	coin_data._on_tossed()
	
	# play the coin's animation
	# $AnimationPlayer.play("spin") 
	# await $AnimationPlayer.animation_finished
	
	coin_data._on_landed()

	var current_luck = coin_data.luck + Player.get_attribute(Player.Attributes.LUCK)
	
	if(current_luck > RandomNumberGenerator.new().randf_range(0.0,100.0)):
		outcome =  coin_data._on_tails()
	else:
		outcome =  coin_data._on_heads()
	landed.emit(outcome)

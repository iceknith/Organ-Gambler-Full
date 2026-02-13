extends Node

###---Variables---###
@export var wave:int = 0
@export var wave_objective:float = 1

var _round:int =0

var _internal_round: int = 0 #infinite recursion block
@export var round: int:
	get:
		return _internal_round
	set(new_round):
		var max_rounds = Player.get_attribute(Player.Attributes.ROUNDS)
		if max_rounds <= 0: return 
		
		if new_round >= max_rounds:
			next_wave()
		else:
			_internal_round = new_round

###---Signals---###
signal new_wave(wave:int, new_objective:float)
signal game_over()

###---Functions---###
func _ready() -> void:
	new_wave.emit.call_deferred(1,wave_objective) # wait for the overlay to load before sending it's signall

func next_wave() -> void:
	print("NEXT WAVE")
	if(Player.money < wave_objective): 
		on_game_over() 
		return
	wave += 1
	round = 0
	Player.money-=wave_objective
	wave_objective = calculate_wave_objective(wave, wave_objective)
	new_wave.emit(wave,wave_objective)

func next_round() -> void:
	round +=1
	# DEBUG
	#print("next round")
	#print("Player.Attributes.ROUNDS: "+ str(Player.get_attribute(Player.Attributes.ROUNDS)))
	#print("GameData roud: "+str(round))
	#print("wave_objective : "+str(wave_objective))
	
func on_game_over() -> void:
	game_over.emit()
	print("game over!")
	wave =0
	round = 0
	Player.money=0
	wave_objective = 1
	new_wave.emit(wave,wave_objective)

func calculate_wave_objective(current_wave:int, previous_wave_objective:int) -> float:
	return previous_wave_objective * (2 + (current_wave / 5))

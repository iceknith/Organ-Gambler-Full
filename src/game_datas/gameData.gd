extends Node

###---Variables---###
@export var wave:int
@export var wave_objective:float

@export var round:int:
	set(new_round):
		if new_round >= Player.get_attribute(Player.Attributes.ROUNDS):
			next_wave()
		else: round = new_round

###---Signals---###
signal new_wave(wave:int, new_objective:float)


###---Functions---###

func next_wave() -> void:
	wave += 1
	round = 0
	wave_objective = calculate_wave_objective(wave, wave_objective)
	new_wave.emit(wave_objective)

func calculate_wave_objective(current_wave:int, previous_wave_objective:int) -> float:
	return previous_wave_objective * (2 + (current_wave / 5))

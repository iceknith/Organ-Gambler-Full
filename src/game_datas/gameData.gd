extends Node

###---Variables---###
@export var wave:int = 0
@export var wave_objective:float = 1

var message_array:Array[Messages] 
# Context messages will be displayed only on top of hub
# You can call and create any message in the folder messages>list using the function request_context_message(MessageLoader.get_message("YOUR MESSAGE"))
# When displayed the messages will be display in order of priority

# call next_wave() automatically when every rounds has ended
var _internal_round: int = 0 #infinite recursion block (do not modify)
@export var round: int: 
	get:
		return _internal_round #infinite recursion block /!\
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

signal message(info:Messages)

###---Functions---###
func _ready() -> void:
	new_wave.emit.call_deferred(1,wave_objective) # wait for the overlay to load before sending it's signall
	request_context_message(MessageLoader.get_message("first_wave"))
	
func next_wave() -> void:
	print("Debug, wave info: wave n" + str(wave) + " wave objectif: " + str(wave_objective))
	# Loose condition:
	if(Player.money < wave_objective): 
		print("Game over: not enough money.")
		on_game_over() 
		return
	# Wave threshold met, innitiating new wave
	wave +=1
	round = 0
	Player.money-=wave_objective
	
	wave_objective = calculate_wave_objective(wave, wave_objective)
	new_wave.emit(wave,wave_objective)

	var message_type = "debug"
	if(wave == 0):message_type = "first_wave"
	else: message_type = "new_wave"
	
	request_context_message(MessageLoader.get_message(message_type))
	

func next_round() -> void:
	round +=1
	
func on_game_over() -> void:
	game_over.emit()
	request_context_message(MessageLoader.get_message("game_over"))
	# palyer setting reset
	wave =0
	round = 0
	Player.money=0
	wave_objective = 1
	new_wave.emit(wave,wave_objective)

func calculate_wave_objective(current_wave:int, previous_wave_objective:int) -> float:
	return previous_wave_objective * (2 + (current_wave / 5))

# Context screen gestion ----------------------------- WORK IN PROGRESS


#Allows any script to request a context message 
func request_context_message(info:Messages) -> void:
	print("gameData recieved message:" + info.title)
	message_array.append(info)
	message_priority_sort()

func message_priority_sort() -> void:
	#insertion sort
	for i in range(message_array.size()):  
		var cle = message_array[i]
		var j = i - 1
		while j >= 0 and cle.priority > message_array[j].priority:
			message_array[j + 1] = message_array[j]
			j-=1
		message_array[j+1] = cle


func display_context_message():
	if !message_array.is_empty():
		# If the current scene is already "context"
		if Main.main.sceneHistory[-1] != "context":
			Main.main.switch_to_scene("context")
		
		await get_tree().process_frame
		
		print("displaying:" + message_array[0].title)
		message.emit(message_array[0])
		message_array.pop_at(0)

# Context done, show next context or stop
func context_finished():
	if(message_array.is_empty()):
		Main.main.go_back()
	else:
		display_context_message()

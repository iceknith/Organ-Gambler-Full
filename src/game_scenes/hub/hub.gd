class_name Hub extends Control


signal message_requested(title,subtitle,body,duration)

var new_wave:bool = false
var game_over:bool = false

func _ready() -> void:
	connect_signals()

func connect_signals():
	# Connect buttons
	$PlayRound.pressed.connect(Main.main.switch_to_scene.bind("round"))
	$Shop.pressed.connect(Main.main.switch_to_scene.bind("shop"))
	$Stats.pressed.connect(Main.main.switch_to_scene.bind("stats"))
	
	GameData.new_wave.connect(on_new_wave)
	GameData.game_over.connect(on_game_over)

func on_game_over() -> void:
	game_over = true
	
func on_new_wave(wave:int,new_objective:int) -> void:
	if(new_objective == 1):
		message_requested.emit("FIRST WAVE","","",1)
	else:
		new_wave = true
	
func return_scene() -> void:
	if(new_wave):
		message_requested.emit("Wave "+str(GameData.wave),"objective "+str(GameData.wave_objective),"good luck",3)
		new_wave =false

	if(game_over):
		message_requested.emit("GAME OVER","","",6)
		game_over =false
	
	

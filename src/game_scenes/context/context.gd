class_name context extends Control

###---Variables---###
@onready var title: Label = $VBoxContainer/Title
@onready var subtitle: Label = $VBoxContainer/Subtitle
@onready var body: Label = $VBoxContainer/Body

@export_group("Display duration:")
@export var duration:float = 3

###---Functions---###
func _ready() -> void:
	clear()
	connect_signals()

func clear() -> void:
	print("CLEARING CONTEXT")
	title.text = ""
	subtitle.text = ""
	body.text = ""

func connect_signals() -> void:
	GameData.new_wave.connect(on_new_wave)
	GameData.game_over.connect(on_game_over)

#Will play automaticly after the scene is displayed on screen
func play_scene() -> void:
	display_timeout() 
	
func on_new_wave(a:int = 0, b:float =0) -> void:
	await get_tree().create_timer(0.5).timeout
	Main.main.switch_to_scene("context")
	title.text = "NEW WAVE !"
	subtitle.text = "the objective is " + str(int(GameData.wave_objective)) + " $"
	
	display_timeout()
	
func on_game_over() -> void:
	Main.main.switch_to_scene("context")
	title.text = "GAME OVER !"
	
func display_timeout() -> void:
	await get_tree().create_timer(duration).timeout
	clear()
	Main.main.go_back()

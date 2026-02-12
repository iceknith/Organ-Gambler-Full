class_name round extends Node2D


func _ready():
	connect_signals()
	
func connect_signals() -> void:
	# Connect button signals
	$Back.pressed.connect(Main.main.go_back)
	$Play.pressed.connect(start_round)
	
	$CoinHandler.hands_finished.connect(end_round)
	
func play_scene() -> void:
	await get_tree().create_timer(1).timeout
	start_round()

func start_round()->void:
	
	for organ in Player.organs:
		organ._on_round_started()
	
	$CoinHandler.playHands()

func end_round()->void:
	for organ in Player.organs:
		organ._on_round_ended()
	Main.main.go_back()

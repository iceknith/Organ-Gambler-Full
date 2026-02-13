class_name round extends Node2D

@export var delay_before_scene:float = 0.4

func _ready():
	connect_signals()
	
func connect_signals() -> void:	
	$CoinHandler.hands_finished.connect(end_round)
	
func play_scene() -> void:
	await get_tree().create_timer(delay_before_scene).timeout
	
	for organ in Player.organs:
		organ._on_round_started()
	
	$CoinHandler.playHands()

func end_round()->void:
	for organ in Player.organs:
		organ._on_round_ended()
	Main.main.go_back()
	
	GameData.next_round()

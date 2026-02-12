class_name round extends Node2D


func _ready():
	connect_signals()
	
func connect_signals() -> void:
	# Connect button signals
	$Back.pressed.connect(Main.main.go_back)
	$Play.pressed.connect($CoinHandler.playHands)
	

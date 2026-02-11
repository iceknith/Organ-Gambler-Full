class_name Hub extends Control


func _ready() -> void:
	connect_signals()

func connect_signals():
	# Connect buttons
	$PlayRound.pressed.connect(Main.main.switch_to_scene.bind("round"))
	$Shop.pressed.connect(Main.main.switch_to_scene.bind("shop"))
	$Stats.pressed.connect(Main.main.switch_to_scene.bind("stats"))
	#$SkipRounds.pressed.connect(GameData.next_wave)

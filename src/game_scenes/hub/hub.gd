class_name Hub extends Control

@onready var coin_slot_scene:PackedScene = preload("res://src/game_scenes/hub/coin_slot/coin_slot.tscn")


func _ready() -> void:
	load_coin_slot()
	connect_signals()

func connect_signals():
	# Connect buttons
	$PlayRound.pressed.connect(Main.main.switch_to_scene.bind("round"))
	$Shop.pressed.connect(Main.main.switch_to_scene.bind("shop"))
	$Stats.pressed.connect(Main.main.switch_to_scene.bind("stats"))
	#$SkipRounds.pressed.connect(GameData.next_wave)

func load_coin_slot():
	var slot:CoinSlot
	for index in Player.maxCoinCount:
		slot = coin_slot_scene.instantiate()
		slot.index = index
		$CoinsContainer.add_child(slot)

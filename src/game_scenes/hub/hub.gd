class_name Hub extends Control


#signal message_requested(title,subtitle,body,duration)

#var new_wave:bool = false
#var game_over:bool = false # ---- /!\

func _ready() -> void:
	connect_signals()

func connect_signals():
	# Connect buttons
	$PlayRound.pressed.connect(Main.main.switch_to_scene.bind("round"))
	$Shop.pressed.connect(Main.main.switch_to_scene.bind("shop"))
	$Stats.pressed.connect(Main.main.switch_to_scene.bind("stats"))

func return_scene() -> void:
	#GameData.context_message() # ---------------------
	pass

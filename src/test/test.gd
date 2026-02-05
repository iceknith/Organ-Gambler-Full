extends Node2D

func _ready() -> void:
	# Await that everything is finished
	await get_tree().process_frame
	await get_tree().process_frame
	
	Player.money += 6
	Player.money *= 6

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		Main.main.switch_to_scene("testRed")
	if Input.is_action_just_pressed("ui_cancel"):
		Main.main.switch_to_scene("testOverlay")

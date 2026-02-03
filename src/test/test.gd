extends Node2D

func _ready() -> void:
	# Await that everything is finished
	await get_tree().process_frame
	await get_tree().process_frame
	
	Player.add_organ(OrganLoader.get_organ("HandDebug"))
	Player.add_organ(OrganLoader.get_organ("HandDebug"))
	print(Player.get_attribute(Player.Attributes.COINS_TOSSED))
	print(Player.get_attribute(Player.Attributes.ROUNDS))

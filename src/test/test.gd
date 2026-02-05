extends Node2D

func _ready() -> void:
	# Await that everything is finished
	await get_tree().process_frame
	await get_tree().process_frame
	
	Player.add_organ(OrganLoader.get_object("HandDebug"))
	Player.add_organ(OrganLoader.get_object("HandDebug"))
	print(Player.get_attribute(Player.Attributes.COINS_TOSSED))
	print(Player.get_attribute(Player.Attributes.ROUNDS))
	
	Player.money += 6
	Player.money *= 6

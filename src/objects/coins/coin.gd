@abstract class_name Coin extends MiscObject

@export var durability:float
@export var base_cost:float

func _to_string() -> String:
	return name

func _on_added():
	pass

func _on_removed():
	pass

func _on_broke():
	pass

func _on_tossed():
	pass

func _on_landed():
	pass

func _on_heads() -> float:
	return 0

func _on_tails() -> float:
	return 0

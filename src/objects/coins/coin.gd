@abstract class_name Coin extends Resource

@export var name:String
@export var description:String
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

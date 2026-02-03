@abstract class_name Coin extends Resource

@export var name:String
@export var description:String
@export var durability:float
@export var base_cost:float

func _on_tossed():
	pass

func _on_heads() -> float:
	return 0

func _on_tails() -> float:
	return 0

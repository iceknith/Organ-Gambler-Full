class_name SimpleCoin extends Coin

@export var valueHeads:float
@export var valueTails:float

func _on_heads() -> float:
	return valueHeads

func _on_tails() -> float:
	return valueTails

@abstract class_name Coin extends MiscObject

@export_group("Bases stats")
@export var durability:float
@export var base_cost:float
@export var luck:float = 50

@export_group("Visuals")
@export var texture:Texture2D
@export var goodSideColor:Color
@export var badSideColor:Color

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

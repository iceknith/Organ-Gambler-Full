@abstract class_name Coin extends MiscObject

@export_group("Bases stats")
@export var durability:float
@export var base_cost:float
@export var luck:float = 50

@export_group("Visuals")
@export var texture:Texture2D
@export var goodSideColor:Color
@export var badSideColor:Color

@export_group("Mouvements")
@export var mouvementMedian:Vector2 = Vector2(0,-500)
@export var variance:Vector2 = Vector2(100,100)

@export_group("AnimationVars")
@export var dist_to_posFinale_perc:float = 1
@export var color_perc:float = 0
@export var decided_color:bool = false
@export var modulateAlpha:float

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

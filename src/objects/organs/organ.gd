class_name Organ extends Resource

signal remove

@export var name:String
@export var description:String
@export var picture:Texture2D
@export var base_cost:float

@export var modifiers:Array[Modifier]

func _on_added():
	pass

func _on_round_started():
	pass

func _on_round_ended():
	pass

func _on_wave_started():
	pass

func _on_wave_ended():
	pass

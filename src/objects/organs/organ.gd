class_name Organ extends MiscObject

signal remove

@export var picture:Texture2D
@export var base_cost:float

@export var modifiers:Array[AttributeModifier]

@export var in_game_sprite:Texture2D


func _to_string() -> String:
	return name

func _on_added():
	pass

func _on_removed():
	pass

func _on_round_started():
	pass

func _on_round_ended():
	pass

func _on_wave_started():
	pass

func _on_wave_ended():
	pass

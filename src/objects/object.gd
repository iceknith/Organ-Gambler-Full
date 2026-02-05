@abstract class_name MiscObject extends Resource

@export var name:String
@export_multiline var description:String
@export var weight:float

func _to_string() -> String:
	return name

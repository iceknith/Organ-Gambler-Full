class_name AttributeModifier extends Resource

@export var type:PlayerObject.Attributes
@export var value:float
@export var valueType:Modifier.ValueTypes

func _to_string() -> String:
	return "%s : %f %s" % [str(type), value, valueType]

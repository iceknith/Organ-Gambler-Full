class_name Modifier extends Resource

enum ValueTypes {
	FLAT, # Add a flat value to the total
	PERCENTAGE, # Add a percentage
	SET # Force set the value
}

@export var type:Player.Attributes
@export var value:float
@export var valueType:ValueTypes

func _to_string() -> String:
	return "%s : %f %s" % [str(type), value, valueType]

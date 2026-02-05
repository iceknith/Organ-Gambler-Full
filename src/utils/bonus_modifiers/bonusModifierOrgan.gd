@tool class_name BonusModifierOrgan extends BonusModifier

@export var organ:String
@export var value:float
@export var valueType:Modifier.ValueTypes

func _apply_bonus() -> void:
	var change_value:int
	match valueType:
		Modifier.ValueTypes.FLAT:
			change_value = value
		Modifier.ValueTypes.PERCENTAGE:
			var organ_count = Player.get_organ_count(organ)
			change_value = roundi(organ_count * value)
		Modifier.ValueTypes.SET:
			var organ_count = Player.get_organ_count(organ)
			change_value = value - organ_count
	
	if change_value >= 0:
		Player.add_organs(organ, value)
	else:
		Player.remove_organs(organ, -value)

###---Editor Stuff---###
func _validate_property(property: Dictionary) -> void:
	if property.name == "organ":
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(OrganLoader.get_objects_names())

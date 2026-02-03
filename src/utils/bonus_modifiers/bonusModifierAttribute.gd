class_name BonusModifierAttribute extends BonusModifier

@export var value:AttributeModifier

func _apply_bonus() -> void:
	Player.add_attribute_modifier(value)

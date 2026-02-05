class_name BonusModifierMoney extends BonusModifier

@export var value:float
@export var valueType:Modifier.ValueTypes

func _apply_bonus() -> void:
	match valueType:
		Modifier.ValueTypes.FLAT:
			Player.money += value
		Modifier.ValueTypes.PERCENTAGE:
			Player.money *= (1 + value)
		Modifier.ValueTypes.SET:
			Player.money = value

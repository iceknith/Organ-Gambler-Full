class_name BonusModifierMoney extends BonusModifier

@export var value:float
@export var valueType:Modifier.ValueTypes

func _apply_bonus() -> void:
	match valueType:
		Modifier.ValueTypes.FLAT:
			Player.add_money(value)
		Modifier.ValueTypes.PERCENTAGE:
			Player.set_money(Player.get_money() * (1 + value))
		Modifier.ValueTypes.SET:
			Player.set_money(value)

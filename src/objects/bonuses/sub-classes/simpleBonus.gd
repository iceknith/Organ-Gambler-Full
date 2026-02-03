class_name SimpleBonus extends Bonus

@export var bonus:BonusModifier
@export var malus:BonusModifier

func _on_bonus_picked():
	bonus._apply_bonus()
	malus._apply_bonus()

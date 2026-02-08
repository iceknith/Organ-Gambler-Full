class_name BonusChoice extends Button


@export var bonus:Bonus = null:
	set(new_bonus):
		bonus = new_bonus
		bonus_change.emit(bonus)
	get(): 
		return bonus

signal bonus_change

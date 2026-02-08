class_name BonusChoice extends Button


@export var bonus:Bonus = null:
	set(new_bonus):
		bonus = new_bonus
		bonus_change.emit(bonus)
	get(): 
		return bonus

signal bonus_change



func _ready():
	bonus_change.connect(display)



func display() -> void:
	if bonus != null:
		text = "{0}\n\n{1}".format([bonus.name, bonus.description])

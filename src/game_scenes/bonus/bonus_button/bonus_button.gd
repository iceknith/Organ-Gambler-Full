class_name BonusChoice extends Button


@export var bonus:Bonus = null:
	set(new_bonus):
		bonus = new_bonus
		bonus_change.emit(bonus)
	get(): 
		return bonus

signal bonus_change

signal bonus_chosen


func _ready():
	bonus_change.connect(display)


func display(new_bonus) -> void:
	if new_bonus != null:
		text = "{0}\n\n{1}".format([new_bonus.name, new_bonus.description])

func _pressed() -> void:
	if bonus != null:
		bonus_chosen.emit(bonus)
		text = "choisi"

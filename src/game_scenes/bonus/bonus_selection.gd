extends Control

@export var bonus_choice_number:int
var bonus_choices:Array[Bonus]

@onready var bonus_scene:PackedScene = preload("res://src/game_scenes/bonus/bonus_button/bonus_button.tscn")

func _ready() -> void:
	load_bonus_slot()
	
	
func load_bonus_slot() -> void:
	
	bonus_choices.clear()
	var bonus_slot:BonusChoice
	
	for index in range(bonus_choice_number):
		bonus_slot = bonus_scene.instantiate()
		$BonusContainer.add_child(bonus_slot)
		bonus_choices.append(bonus_slot)

func load_random_bonus(index) -> void:
	
	var random_bonus:Bonus = BonusLoader.get_random_object()
	bonus_choices[index].set("bonus",random_bonus)
	
func reroll():
	for index in range(bonus_choice_number):
		load_random_bonus(index)

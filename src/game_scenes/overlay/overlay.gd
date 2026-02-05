extends Control

@onready var moneyLabel:Label = $TextContainer/Money
@onready var objectiveLabel:Label = $TextContainer/Objective

# Initializers
func _ready() -> void:
	initialize_signals()

func initialize_signals() -> void:
	Player.money_change.connect(_on_player_money_change)
	GameData.new_wave.connect(_on_new_wave)


# Signals receptors
func _on_player_money_change(new_money_count:float) -> void:
	moneyLabel.text = str(roundf(new_money_count*10)/10)

func _on_new_wave(wave:int, new_objective:float) -> void:
	objectiveLabel.text = str(roundf(new_objective*10)/10)

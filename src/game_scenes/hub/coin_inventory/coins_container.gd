extends GridContainer

@onready var coin_slot_scene:PackedScene = preload("res://src/game_scenes/hub/coin_inventory/coin_slot.tscn")


func _ready() -> void:
	Player.coin_added.connect(auto_select)
	
	load_coin_slot()

func load_coin_slot():
	var slot:CoinSlot
	for index in Player.maxCoinCount:
		slot = coin_slot_scene.instantiate()
		slot.index = index
		if index == 0 : slot.button_pressed = true
		slot.select.connect(deselect_others)
		add_child(slot)

func deselect_others(selected:Button):
	for button:Button in get_children():
		if button != selected:
			button.button_pressed = false

func auto_select() -> void:
	if Player.get_selected_coin() == null:
		for button:Button in get_children():
			if button.coin != null:
				button.button_pressed = true
				break

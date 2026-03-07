extends GridContainer

@onready var coin_slot_scene:PackedScene = preload("res://src/game_scenes/hub/coin_inventory/coin_slot.tscn")
var confirm_label:Label

func _ready() -> void:
	
	confirm_label = get_parent().get_child(1)
	
	Player.coin_added.connect(auto_select)
	confirm_label.get_child(0).pressed.connect(_on_yes_pressed)
	confirm_label.get_child(1).pressed.connect(_on_no_pressed)
	
	load_coin_slot()

func load_coin_slot() -> void:
	var slot:CoinSlot
	for index in Player.maxCoinCount:
		slot = coin_slot_scene.instantiate()
		slot.index = index
		if index == 0 : slot.button_pressed = true
		slot.select.connect(deselect_others)
		slot.try_to_delete.connect(display_confirm_screen)
		add_child(slot)

func get_coin_slot(index:int) -> CoinSlot:
	for slot:CoinSlot in get_children():
		if slot.index == Player.selectedCoinIndex:
			return slot
	return null


func deselect_others(selected:Button) -> void:
	for button:Button in get_children():
		if button != selected:
			button.button_pressed = false
			button.get_child(0).visible = false

func auto_select() -> void:
	if Player.get_selected_coin() == null:
		for button:CoinSlot in get_children():
			if button.coin != null:
				button.button_pressed = true
				button.get_child(0).visible = true
				Player.selectedCoinIndex = button.index
				break

func display_confirm_screen() -> void:
	confirm_label.visible = true


func _on_yes_pressed() -> void:
	print("deleting...")
	confirm_label.visible = false
	#delete coin and refresh
	var slot:CoinSlot = get_coin_slot(Player.selectedCoinIndex)
	Player.remove_coin(Player.selectedCoinIndex)
	slot.refresh()
	slot.get_child(0).visible = false #hide delete button
	auto_select()


func _on_no_pressed() -> void:
	confirm_label.visible = false

extends GridContainer

@onready var coin_slot_scene:PackedScene = preload("res://src/game_scenes/hub/coin_inventory/coin_slot.tscn")
var confirm_label:Label

func _ready() -> void:
	
	confirm_label = get_parent().get_child(1)
	
	Player.coin_added.connect(auto_select)
	confirm_label.get_child(0).pressed.connect(_on_yes_pressed)
	confirm_label.get_child(1).pressed.connect(_on_no_pressed)
	
	load_coin_slot()

func load_coin_slot():
	var slot:CoinSlot
	for index in Player.maxCoinCount:
		slot = coin_slot_scene.instantiate()
		slot.index = index
		if index == 0 : slot.button_pressed = true
		slot.select.connect(deselect_others)
		slot.try_to_delete.connect(display_confirm_screen)
		add_child(slot)

func deselect_others(selected:Button):
	for button:Button in get_children():
		if button != selected:
			button.button_pressed = false
			button.get_child(0).visible = false

func auto_select() -> void:
	if Player.get_selected_coin() == null:
		for button:Button in get_children():
			if button.coin != null:
				button.button_pressed = true
				button.get_child(0).visible = true
				break
				

func display_confirm_screen():
	confirm_label.visible = true


func _on_yes_pressed() -> void:
	print("deleting...")
	#delete coin and refresh
	pass


func _on_no_pressed() -> void:
	confirm_label.visible = false

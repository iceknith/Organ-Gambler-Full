extends Node

var coins:Dictionary

func _ready() -> void:
	load_coins()

func load_coins() -> void:
	var dir := DirAccess.open("res://src/objects/coins/list")
	if dir == null: printerr("Could not open folder res://src/objects/coins/list"); return
	dir.list_dir_begin()
	for file:String in dir.get_files():
		var coin:Coin = load(dir.get_current_dir() + "/" + file)
		coins.set(coin.name, dir.get_current_dir() + "/" + file)

func get_coin(name:String) -> Coin:
	if (coins.has(name)): return load(coins.get(name))
	printerr("No coins matching the name " + name + " found !")
	return null

extends Node

var bonuses:Dictionary

func _ready() -> void:
	load_bonuses()

func load_bonuses() -> void:
	var dir := DirAccess.open("res://src/objects/bonuses/list")
	if dir == null: printerr("Could not open folder res://src/objects/bonuses/list"); return
	dir.list_dir_begin()
	for file:String in dir.get_files():
		var bonus:Bonus = load(dir.get_current_dir() + "/" + file)
		bonuses.set(bonus.name, dir.get_current_dir() + "/" + file)

func get_bonus(name:String) -> Bonus:
	if (bonuses.has(name)): return load(bonuses.get(name))
	printerr("No bonus matching the name " + name + " found !")
	return null

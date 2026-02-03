extends Node

# Note pour le futur, on peut sub-diviser ce dictionaire en plusieurs dicts de différentes catégories
# pour nous économiser du temps de traitement
var organs:Dictionary

func _ready() -> void:
	load_organs()

func load_organs() -> void:
	var dir := DirAccess.open("res://src/objects/organs/list")
	if dir == null: printerr("Could not open folder res://src/objects/organs/list"); return
	dir.list_dir_begin()
	for file:String in dir.get_files():
		var organ:Organ = load(dir.get_current_dir() + "/" + file)
		organs.set(organ.name, dir.get_current_dir() + "/" + file)

func get_organ(name:String) -> Organ:
	if (organs.has(name)): return load(organs.get(name))
	printerr("No organ matching the name " + name + " found !")
	return null

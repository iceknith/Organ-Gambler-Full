@tool class_name MiscObjectLoader extends Node

@export var path:String
var objects:Dictionary[String, MiscObject]
var objectsProba:Dictionary[String, float]
var totalWeights:float

var randomGenerator:RandomNumberGenerator

func _ready() -> void:
	load_objects()

func load_objects() -> void:
	var dir := DirAccess.open(path)
	if dir == null: printerr("Could not open folder"+path); return
	dir.list_dir_begin()
	totalWeights = 0
	for file:String in dir.get_files():
		var object:Object = load(dir.get_current_dir() + "/" + file)
		objects.set(object.name, object)
		totalWeights += object.weight
		objectsProba.set(object.name, object.weight)
	
	for name in objectsProba:
		objectsProba[name] /= totalWeights
	
	randomGenerator = RandomNumberGenerator.new()

func get_objects_names() -> Array[String]:
	var dir := DirAccess.open(path)
	if dir == null: printerr("Could not open folder"+path); return []
	dir.list_dir_begin()
	var result:Array[String] = []
	for file:String in dir.get_files():
		var object:Object = load(dir.get_current_dir() + "/" + file)
		result.append(object.name)
	return result

func get_object(name: StringName) -> Object:
	if (objects.has(name)): return objects.get(name)
	printerr("No objects matching the name " + name + " found !")
	return null

func get_random_object() -> Object:
	var names:Array = objectsProba.keys()
	var proba:Array = objectsProba.values()
	var pickedObj:int = randomGenerator.rand_weighted(proba)
	return objects.get(names[pickedObj])

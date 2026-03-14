class_name messageLoader extends Node

var message_paths := {}

var path = "res://src/messages/list/"

var debug_message = load("res://src/messages/list/debug.tres")

func _ready() -> void:
	load_message_path()


func load_message_path() -> void:
	var dir := DirAccess.open(path)
	if dir == null:
		printerr("Could not open folder " + path)
		return

	dir.list_dir_begin()
	var file_name := dir.get_next()
	while file_name != "":
		if !dir.current_is_dir() and file_name.ends_with(".tres"):
			var name := file_name.get_basename()
			message_paths[name] = path + file_name
		file_name = dir.get_next()

	dir.list_dir_end()

func get_message(name:String) -> Messages:
	"""
	if not message_paths.has(name):
		push_error("Message not found: " + name)
		return null
		"""
	return debug_message#message_paths[name])

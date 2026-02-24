class_name context extends Control

###---Variables---###
@onready var title: Label = $VBoxContainer/Title
@onready var subtitle: Label = $VBoxContainer/Subtitle
@onready var body: Label = $VBoxContainer/Body

@export_group("Display duration:")
@export var duration:float = 2

###---Functions---###
func _ready() -> void:
	clear()


signal context_finished

func display_message(_title:String="", _subtitle:String= "", _body:String ="", _duration:float =0):
	print("debug?")
	title.text = _title
	subtitle.text = _subtitle
	body.text =  _body
	#Main.main.switch_to_scene("context")
	
	# display timeout
	if _duration == 0 : await get_tree().create_timer(duration).timeout
	else: await get_tree().create_timer(_duration).timeout
	clear()
	context_finished.emit() 

func clear() -> void:
	title.text = ""
	subtitle.text = ""
	body.text = ""

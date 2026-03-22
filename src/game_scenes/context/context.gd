class_name context extends Control

###---Variables---###
@onready var title: Label = $VBoxContainer/Title
@onready var subtitle: Label = $VBoxContainer/Subtitle
@onready var body: Label = $VBoxContainer/Body

@export_group("Display duration:")
@export var base_duration:float = 1

###---Signals---###
signal context_finished

###---Functions---###
func _ready() -> void:
	clear()
	connect_signals()
	

func connect_signals() -> void:
	GameData.message.connect(display_message)

func display_message(info:Messages):
	var t = Utils.text_processor( info.title)
	print("CONTEXT : DISPLAYING MESSAGE :" + t)
	title.text = t
	subtitle.text =  Utils.text_processor( info.subtitle)
	body.text =   Utils.text_processor( info.body)
	
	# display timeout
	if info.duration == 0 : await get_tree().create_timer(base_duration).timeout
	else: await get_tree().create_timer(info.duration).timeout
	#clear()
	context_finished.emit() 

func clear() -> void:
	title.text = ""
	subtitle.text = ""
	body.text = ""

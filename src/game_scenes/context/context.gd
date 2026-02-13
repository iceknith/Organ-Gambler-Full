class_name context extends Control


@onready var title: Label = $VBoxContainer/Title
@onready var subtitle: Label = $VBoxContainer/Subtitle
@onready var body: Label = $VBoxContainer/Body


func _ready() -> void:
	clear()


func clear() -> void:
	title.text = ""
	subtitle.text = ""
	body.text = ""

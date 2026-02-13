class_name handVisual extends Node2D

###---Variables---###
@export var hand_position_offcet:float = 100
var hand_data:Organ 
var landing_position:Vector2
var window_height = ProjectSettings.get_setting("display/window/size/viewport_height")
###---Functions---###

func _ready() -> void:
	update_visuals()
	position = Vector2(landing_position.x,window_height-hand_position_offcet)

func update_visuals() -> void:
	pass

func _process(delta: float) -> void:
	position.y += 2 #hide the hand after spawn

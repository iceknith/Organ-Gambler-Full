class_name GenericSceneTransition extends SceneTransition

@export var attribute:String
@export var start_value:Variant
@export var end_value:Variant

func get_property() -> String:
	return "position"

func start_val() -> Variant:
	return start_value

func end_val() -> Variant:
	return end_value

func active_scene_start_val() -> Variant:
	return start_value

func active_scene_end_val() -> Variant:
	return end_value

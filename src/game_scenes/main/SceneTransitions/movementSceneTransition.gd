class_name MovementSceneTransition extends SceneTransition

@export var transition_direction:Vector2

func get_property() -> String:
	return "position"

func start_val() -> Variant:
	var visibleRect:Rect2 = Main.main.get_viewport().get_visible_rect()
	return visibleRect.size * transition_direction

func end_val() -> Variant:
	return Vector2.ZERO

func active_scene_start_val() -> Variant:
	return Vector2.ZERO

func active_scene_end_val() -> Variant:
	var visibleRect:Rect2 = Main.main.get_viewport().get_visible_rect()
	return visibleRect.size *  (-transition_direction)

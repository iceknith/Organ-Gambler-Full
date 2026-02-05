@abstract class_name SceneTransition extends Resource

enum TransitionTypes {
	OVERLAY,
	REPLACE
}

@export var scene:PackedScene
@export var type:TransitionTypes
@export_category("Transition")
@export var transition_ease:Tween.EaseType = Tween.EASE_IN_OUT
@export var transition_type:Tween.TransitionType = Tween.TRANS_CIRC
@export var transition_duration:float
@export_category("Invert Transition")
@export var invert_transition_ease:Tween.EaseType = Tween.EASE_IN_OUT
@export var invert_transition_type:Tween.TransitionType = Tween.TRANS_CIRC
@export var invert_transition_duration:float

# Functions
@abstract func get_property() -> String
@abstract func start_val() -> Variant
@abstract func end_val() -> Variant
@abstract func active_scene_start_val() -> Variant
@abstract func active_scene_end_val() -> Variant

func invert_start_val() -> Variant: return end_val()
func invert_end_val() -> Variant: return start_val()
func invert_active_scene_start_val() -> Variant: return active_scene_end_val()
func invert_active_scene_end_val() -> Variant: return active_scene_start_val()

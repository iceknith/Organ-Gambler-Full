class_name SceneTransition extends Resource

enum TransitionTypes {
	OVERLAY,
	REPLACE
}

@export var scene:PackedScene
@export var type:TransitionTypes
@export var disable_previous_node_process:bool
@export_category("Transition")
@export var transition_ease:Tween.EaseType = Tween.EASE_IN_OUT
@export var transition_type:Tween.TransitionType = Tween.TRANS_CIRC
@export var transition_duration:float
@export var transition_direction:Vector2

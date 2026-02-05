# Is a singleton
class_name Main extends Node

static var main:Main = null:
	get(): 
		return main 
	set(new_main): 
		if main: return
		else: main = new_main

@export var scenes:Dictionary[String, SceneTransition]
@export var firstScene:String
var sceneHistory:Array[String]
var tween:Tween
var can_transition:bool = true

# Initialization functions
func _ready() -> void:
	if main != null: push_error("Main already instantiated"); return
	main = self
	initialize_scenes()

func initialize_scenes():
	for sceneName in scenes:
		var sceneTransition:SceneTransition = scenes[sceneName]
		var scene:Node = sceneTransition.scene.instantiate()
		scene.name = sceneName
		
		# If the scene is not the first, hide it
		if sceneName != firstScene:
			hide(scene)
		
		$GameScenes.add_child(scene)
	# Add the first scene to the scene history
	sceneHistory.append(firstScene)

# Scene switching functions
func switch_to_scene(sceneName:String, transition:SceneTransition = null) -> void:
	# This function uses the default transition, except when transition is entered
	# If transition is entered, the "scene" attribute is not used
	if !can_transition: push_warning("Another transition is ongoing !"); return
	if sceneHistory.is_empty(): printerr("No history !"); return
	if sceneName == sceneHistory[-1]: go_back(); return # If scene is already in focus, toggle it
	
	var current_scene:Node = get_node("GameScenes/%s" % [sceneHistory[-1]])
	var next_scene:Node = get_node("GameScenes/%s" % sceneName) 
	if !transition: transition = scenes.get(sceneName)
	
	if !transition: printerr("No transitions associated with this scene !"); return
	
	# The transition is validated
	can_transition = false
	
	# Setup the scene
	next_scene.set(transition.get_property(), transition.start_val())
	show(next_scene)
	# Setup the tween
	if tween: tween.kill()
	tween = create_tween()
	tween.set_ease(transition.transition_ease).set_trans(transition.transition_type)
	tween.tween_property(next_scene, transition.get_property(),
		transition.end_val(), transition.transition_duration)
	
	# If the mode is "replace"
	if transition.type == SceneTransition.TransitionTypes.REPLACE:
		# Setup the parallel tween
		tween.parallel().tween_property(current_scene, transition.get_property(),
			transition.active_scene_end_val(), transition.transition_duration)
	# Else, put the current scene over the previous one
	elif next_scene.z_index <= current_scene.z_index:
		next_scene.z_index = current_scene.z_index + 1 
	
	# At the end of the tween
	await tween.finished
	# Hide the current_scene if mode is replace
	if transition.type == SceneTransition.TransitionTypes.REPLACE:
		hide(current_scene) 
	
	# Register the scene name on the history
	sceneHistory.push_back(sceneName)
	can_transition = true

func go_back(transition:SceneTransition = null) -> void:
	# This function uses the default transition, except when transition is entered
	# If transition is entered, the "scene" attribute is not used
	if !can_transition: push_warning("Another transition is ongoing !"); return
	if (sceneHistory.is_empty()): printerr("No history !"); return
	if (sceneHistory.size() < 2): printerr("Only one scene in history, can't operate"); return
	
	var current_scene:Node = get_node("GameScenes/%s" % [sceneHistory[-1]])
	var previous_scene:Node = get_node("GameScenes/%s" % [sceneHistory[-2]]) 
	if !transition: transition = scenes.get(current_scene.name)
	
	if !transition: printerr("No transitions associated with this scene !"); return
	
	# The transition is validated
	can_transition = false
	
	# Setup the tween
	if tween: tween.kill()
	tween = create_tween()
	tween.set_ease(transition.invert_transition_ease).set_trans(transition.invert_transition_type)
	
	tween.tween_property(current_scene, transition.get_property(),
		transition.invert_end_val(), transition.invert_transition_duration)
	
	# If the mode is "replace"
	if transition.type == SceneTransition.TransitionTypes.REPLACE:
		# Setup the other scene
		show(previous_scene)
		# Setup the parallel tween
		tween.parallel().tween_property(previous_scene, transition.get_property(),
			transition.invert_active_scene_end_val(), transition.invert_transition_duration)
	
	# At the end of the tween
	await tween.finished
	# If the mode is replace, hide the previous scene
	if transition.type == SceneTransition.TransitionTypes.REPLACE: 
		hide(current_scene)
	# remove the name from the history
	sceneHistory.pop_back()
	can_transition = true

func hide(node:Node) -> void:
	if (node as Control) or (node as Node2D) or (node as Node3D):
		node.hide()
	node.process_mode = Node.PROCESS_MODE_DISABLED

func show(node:Node) -> void:
	if (node as Control) or (node as Node2D) or (node as Node3D):
		node.show()
	node.process_mode = Node.PROCESS_MODE_INHERIT

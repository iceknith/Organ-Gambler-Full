# Is a singleton
class_name Main extends Node

static var main:Main = null:
	get(): 
		if main == null: push_error("Main not instantiated !")
		return main 
	set(new_main): return # Delete the set

@export var scenes:Dictionary[String, SceneTransition]
@export var firstScene:String
var sceneHistory:Array[String]
var tween:Tween

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
			if (scene as Control) or (scene as Node2D) or (scene as Node3D):
				scene.hide()
			scene.process_mode = Node.PROCESS_MODE_DISABLED
		
		$GameScenes.add_child(scene)


# Scene switching functions
func switch_to_scene(sceneName:String, transition:SceneTransition = null) -> void:
	# This function uses the default transition, except when transition is entered
	# If transition is entered, the "scene" attribute is not used
	pass

func go_back(transition:SceneTransition = null) -> void:
	pass

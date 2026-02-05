extends Node

@export var scenes:Dictionary[String, SceneTransition]
@export var firstScene:String
var sceneHistory:Array[String]

var tween:Tween

# Initialization functions
func _init() -> void:
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

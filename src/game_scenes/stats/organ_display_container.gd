extends Container


func _ready():
	await get_tree().process_frame
	load_organs()

func load_organs() -> void:
	var image:TextureRect
	var oldImage:TextureRect = get_child(0).duplicate()
	for child in get_children(): child.queue_free()
	for organ in Player.organs:
		#print(str(organ))
		image = oldImage.duplicate()
		#image.texture = load(OrganVars.organs[organ]["image"])
		add_child(image)

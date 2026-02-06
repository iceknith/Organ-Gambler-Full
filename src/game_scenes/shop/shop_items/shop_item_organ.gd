class_name ShopItemOrgan extends ShopItem

signal organ_change

@export var organ:Organ = null:
	set(new_organ):
		organ = new_organ
		organ_change.emit(organ)
	get(): 
		return organ

func _ready():
	super._ready()
	
	organ_change.connect(load_organ)

func load_organ(new_organ:Organ) -> void:
	
	if new_organ != null:
		#$Button.icon = Organ.picture
		$Button.text = new_organ.name
		tooltip1 = new_organ.name
		tooltip2 = new_organ.description
	else:
		tooltip1 = ""
		tooltip2 = ""
		$Button.text = "empty"
	$Button.tooltip_text = "{0}\n{1}\n{2}".format([tooltip1, tooltip2, tooltip3])

func bought():
	super.bought()
	#ajout de l'organe à l'inventaire
	set("organ",null)
	pass

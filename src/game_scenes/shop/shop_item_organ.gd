class_name ShopItemOrgan extends ShopItem

@export var item:Organ

func load_organ(organ:Organ, price:float) -> void:
	item = organ
	cost = price
	#$Button.icon = Organ.picture
	$Button.text = item.name
	$Button.tooltip_text = "%s\n%s\n%s".format([item.name, item.description, price])

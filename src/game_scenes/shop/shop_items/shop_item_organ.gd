class_name ShopItemOrgan extends ShopItem

@export var item:Organ

func load_organ(organ:Organ, price:float) -> void:
	item = organ
	cost = price
	#$Button.icon = Organ.picture
	$Button.text = item.name
	$Button.tooltip_text = "{0}\n{1}\n{2}".format([item.name, item.description, price])

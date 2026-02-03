class_name AttributeModifierHandler extends RefCounted

var type:Player.Attributes
var flat_attr:Array[float] = [] # Adds flat to value
var perc_attr:Array[float] = [] # Adds a percentage of the value
var set_attr:Array[float] = [] # Hard sets the value, only the last item of set_attr is the one registered

func _init(type:Player.Attributes) -> void:
	self.type = type

func add(modif:AttributeModifier) -> void:
	if modif.type != type: 
		printerr("Invalid Modifier type, expected %s, got %s" % [str(type), str(modif.type)])
		return
	
	match modif.valueType:
		Modifier.ValueTypes.FLAT:
			flat_attr.append(modif.value)
		Modifier.ValueTypes.PERCENTAGE:
			perc_attr.append(modif.value)
		Modifier.ValueTypes.SET:
			set_attr.append(modif.value)

func remove(modif:AttributeModifier) -> void:
	if modif.type != type: 
		printerr("Invalid Modifier type, expected %s, got %s" % [str(type), str(modif.type)])
		return
	
	match modif.valueType:
		Modifier.ValueTypes.FLAT:
			flat_attr.erase(modif.value)
		Modifier.ValueTypes.PERCENTAGE:
			perc_attr.erase(modif.value)
		Modifier.ValueTypes.SET:
			set_attr.erase(modif.value)

func get_modified_val(val:float) -> float:
	# Set
	if !set_attr.is_empty():
		return set_attr[-1]
	
	# Flat
	for flat in flat_attr: 
		val += flat
	
	# Percentage
	var total_perc:float
	for perc in perc_attr:
		total_perc += perc
	val *= 1 + total_perc
	
	return val

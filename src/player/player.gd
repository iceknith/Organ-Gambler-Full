extends Node

###---Constants---###
enum Attributes {
	COINS_TOSSED,
	ROUNDS,
	VALUE_ADD,
	VALUE_MULT,
	LUCK,
	NULL
}

###---Variables---###
@export var money:float = 0
@export var baseStats:Dictionary[Attributes,float] = {
	Attributes.LUCK : 1
} # All of the others attributes are initialized to 0

# Organs
@export var defaultOrgans:Array[String] = [
	"Hand", "Hand"
]
var organs:Array[Organ]

# Modifiers
var modifierHandlers:Dictionary[Attributes, ModifierHandler] = {}

# Coins
@export var defaultCoins:Array[String] = [
]
var coins:Array[Coin]


###---Signals---#
signal money_change(new_money_count:float)
signal organ_added(organ:Organ)
signal organ_removed(organ:Organ)

###---Getters---###
func get_attribute(attr:Attributes) -> float:
	var defaultVal:float = baseStats.get(attr, 0)
	
	var modifierHandler:ModifierHandler = modifierHandlers.get(attr)
	if modifierHandler:
		return modifierHandler.get_modified_val(defaultVal)
	
	return defaultVal

###---Setters---###
func add_money(added_money:float) -> void:
	money += added_money
	money_change.emit(money)

func add_organ(organ:Organ) -> void:
	organs.append(organ)
	# Iterate through modifiers
	for modifier in organ.modifiers:
		# Adding them to their corresponding ModifierHandler
		var modifierHandler:ModifierHandler = modifierHandlers.get_or_add(modifier.type, ModifierHandler.new(modifier.type))
		modifierHandler.add(modifier)
	# Call organ "_on_added" method
	organ._on_added()

func remove_organ(organ:Organ) -> void:
	if organs.has(organ):
		organs.erase(organ)
		# Iterate through modifiers
		for modifier in organ.modifiers:
			# Removing them from their corresponding MoifierHandler
			var modifierHandler:ModifierHandler = modifierHandlers.get(modifier.type)
			if !modifierHandler: printerr("Error, modifiers weren't properly initialized and can't get deleted"); return
			modifierHandler.remove(modifier)
	else:
		printerr("Tried to erase the organ: %s but it doesn't exist in body" % [str(organ)])

###---Functions---###

# Initialisation functions
func _ready() -> void:
	# Wait for the ressources to be loaded
	await get_tree().process_frame
	
	# Add default Organs
	load_default_organs()
	
	# Add default Coins
	load_default_coins()

func load_default_organs() -> void:
	for organName:String in defaultOrgans:
		var organ:Organ = OrganLoader.get_organ(organName)
		if organ: add_organ(organ)

func load_default_coins() -> void:
	pass

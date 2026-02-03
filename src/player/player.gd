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
var attributeModifierHandlers:Dictionary[Attributes, AttributeModifierHandler] = {}

# Coins
@export var maxCoinCount:int = 6
@export var defaultCoins:Array[String] = [
	"SimpleCoin"
]
var coins:Array[Coin]

###---Signals---#
signal money_change(new_money_count:float)
signal organ_added(organ:Organ)
signal organ_removed(organ:Organ)
signal coin_added(coin:Coin)
signal coin_removed(coin:Coin)

###---Getters---###
func get_money() -> float:
	return money

func get_attribute(attr:Attributes) -> float:
	var defaultVal:float = baseStats.get(attr, 0)
	
	var modifierHandler:AttributeModifierHandler = attributeModifierHandlers.get(attr)
	if modifierHandler:
		return modifierHandler.get_modified_val(defaultVal)
	
	return defaultVal

func get_organ_count(organ_name:String) -> int:
	var count:int = 0
	for organ in organs: 
		if organ.name == organ_name: count += 1
	return count

###---Setters---###
func add_money(added_money:float) -> void:
	set_money(money + added_money)

func set_money(new_money:float) -> void:
	money = new_money
	money_change.emit(money)

func add_organ(organ:Organ) -> void:
	organs.append(organ)
	for modifier in organ.modifiers:
		add_attribute_modifier(modifier)
		
	# Notify change
	organ._on_added()
	organ_added.emit(organ)

func remove_organ(organ:Organ) -> void:
	if organs.has(organ):
		organs.erase(organ)
		
		for modifier in organ.modifiers:
			remove_attribute_modifier(modifier)
		
		# Notify change
		organ._on_removed()
		organ_removed.emit(organ)
	else:
		printerr("Tried to remove the organ \"%s\" but none was found" % [str(organ)])

func add_organs(organ_name:String, amount:int = 1) -> void:
	for i in amount:
		var organ:Organ = OrganLoader.get_object(organ_name)
		if organ: add_organ(organ)

func remove_organs(organ_name:String, amount:int = 1) -> void:
	var original_amount:int = amount
	
	for i in organs.size():
		if organs[i].name == organ_name:
			var organ = organs[i]
			organs.remove_at(i)
			for modifier in organ.modifiers:
				remove_attribute_modifier(modifier)
			
			# Notify change
			organ._on_removed()
			organ_removed.emit(organ)
			
			# Decrement
			amount -= 1
			if amount <= 0: return
	
	printerr("Could not remove %i \"%s\", %i were found and removed" % 
		[original_amount, organ_name, original_amount - amount])

func add_attribute_modifier(modifier:AttributeModifier) -> void:
	var modifierHandler:AttributeModifierHandler = attributeModifierHandlers.get_or_add(modifier.type, AttributeModifierHandler.new(modifier.type))
	modifierHandler.add(modifier)

func remove_attribute_modifier(modifier:AttributeModifier) -> void:
	var modifierHandler:AttributeModifierHandler = attributeModifierHandlers.get(modifier.type)
	if !modifierHandler: printerr("Error, modifiers weren't properly initialized and can't get deleted"); return
	modifierHandler.remove(modifier)

func add_coin(coin:Coin) -> void:
	if coins.size() >= maxCoinCount: printerr("Coin %s could not be added because player has already max amount of coins" % [str(coin)]); return
	coins.append(coin)
	# Notify change
	coin._on_added()
	coin_added.emit(coin)

func remove_coin(coin:Coin) -> void:
	if coins.has(coin):
		coins.erase(coin)
		# Notify change
		coin._on_removed()
		coin_removed.emit(coin)
	else:
		printerr("Tried to remove the coin: %s but it doesn't exist in player" % [str(coins)])

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
	for organ_name:String in defaultOrgans:
		add_organs(organ_name)

func load_default_coins() -> void:
	for coin_name:String in defaultCoins:
		var coin:Coin = CoinLoader.get_object(coin_name)
		if coin: add_coin(coin)

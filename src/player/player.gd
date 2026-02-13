@tool class_name PlayerObject extends Node


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
@export var money:float = 0:
	set(new_money):
		money = new_money
		money_change.emit(money)
	get(): 
		return money
@export var baseStats:Dictionary[Attributes,float] = {
	Attributes.LUCK : 1
} # All of the others attributes are initialized to 0

# Organs
@export var defaultOrgans:Array[String] = [
]
var organs:Array[Organ]

# Modifiers
var attributeModifierHandlers:Dictionary[Attributes, AttributeModifierHandler] = {}

# Coins
@export var selectedCoinIndex:int = 0
@export var maxCoinCount:int = 6
@export var defaultCoins:Array[String] = [
	"BaseCoin"
]
var coins:Array[Coin]

###---Signals---###
signal money_change(new_money_count:float)
signal organ_added(organ:Organ)
signal organ_removed(organ:Organ)
signal coin_added(coin:Coin)
signal coin_removed(coin:Coin)

###---Getters---###
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

func get_total_coin_count() -> int:
	var count:int = 0
	for coin in coins: 
		if coin != null: count += 1
	return count

func get_selected_coin() -> Coin:
	var coin = coins[selectedCoinIndex]
	if not coin: printerr("Plus de coins disponibles")
	return coin


###---Setters---###
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
	for index in range(maxCoinCount):
		if coins[index] == null:
			coins[index] = coin
			coin_added.emit()
			return
	printerr("Coin %s could not be added because player has already max amount of coins" % [str(coin)]); return


func remove_coin(index) -> void:
	var coin:Coin
	if coins[index] != null:
		coin = coins[index]
		coins[index] = null
		# Notify change
		coin._on_removed()
		coin_removed.emit(coin)
	else:
		printerr("Tried to remove the coin: %s but it doesn't exist in player" % [str(coins)])

###---Functions---###

# Initialisation functions
func _ready() -> void:
	# Insta quit if is in editor
	if Engine.is_editor_hint(): return
	
	# Wait for the ressources to be loaded
	await get_tree().process_frame
	
	# Add default Organs
	load_default_organs()
	
	# Add default Coins
	load_default_coins()
	
	GameData.game_over.connect(on_game_over)

func load_default_organs() -> void:
	for organ_name:String in defaultOrgans:
		add_organs(organ_name)

func load_default_coins() -> void:
	for index in range(maxCoinCount):
		coins.append(null)
	for coin_name:String in defaultCoins:
		var coin:Coin = CoinLoader.get_object(coin_name)
		if coin: add_coin(coin)
	print(coins)

func on_game_over() -> void:
	pass

###---Editor Stuff---###
func _validate_property(property: Dictionary) -> void:
	if property.name == "defaultOrgans":
		property.hint_string = \
			str(TYPE_STRING) + "/" + str(PROPERTY_HINT_ENUM) + ":" + ",".join(OrganLoader.get_objects_names())
	if property.name == "defaultCoins":
		property.hint_string = \
			str(TYPE_STRING) + "/" + str(PROPERTY_HINT_ENUM) + ":" + ",".join(CoinLoader.get_objects_names())

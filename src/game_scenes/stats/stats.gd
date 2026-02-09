extends Control

###---Nodes---###
@onready var label_1: Label = $VBoxContainer/HBoxContainer/Label1
@onready var label_2: Label = $VBoxContainer/HBoxContainer/Label2
@onready var organs_container: GridContainer = $VBoxContainer/ScrollContainer/MarginContainer/OrgansContainer

###---Variables---###
var label1_innit_text:String
var label2_innit_text:String

# Reprend le fonctionnement du stats screen de la jam
func _ready():
	connect_signals()
	
	label1_innit_text = label_1.text
	label2_innit_text = label_2.text
	refresh()

func connect_signals():
	# Stats Changing
	Player.money_change.connect(_on_money_changed)
	Player.organ_added.connect(_refresh_organ)
	#Player.organ_removed.connect(_refresh_organ)
	
	# Button signals
	$Back.pressed.connect(Main.main.go_back)

func refresh():
	label_1.text = label1_innit_text
	label_1.text = label_1.text.replace("$wave", str(GameData.wave))
	label_1.text = label_1.text.replace("$COINS_TOSSED", str(Player.get_attribute(Player.Attributes.COINS_TOSSED)))
	label_1.text = label_1.text.replace("$Money", str(Player.money)) 
	
	label_2.text = label2_innit_text
	label_2.text = label_2.text.replace("$VALUE_ADD",  str(Player.get_attribute(Player.Attributes.VALUE_ADD)))
	label_2.text = label_2.text.replace("$VALUE_MULT", str(Player.get_attribute(Player.Attributes.VALUE_MULT)))
	label_2.text = label_2.text.replace("$Luck", str(Player.get_attribute(Player.Attributes.LUCK))) 

func _on_money_changed(new_money_count:float=0)->void:
	refresh()


func _refresh_organ(_organ_changed:Organ=null)->void:
	organs_container.load_organs()

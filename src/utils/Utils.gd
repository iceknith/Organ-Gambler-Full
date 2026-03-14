extends Object


#Text variable transaltion
func text_processor(text:String) -> String:
	text = text.replace("$wave", str(GameData.wave))
	text = text.replace("$Money", str(Player.money))
	text = text.replace("$wave", str(GameData.wave))
	text = text.replace("$round", str(Player.get_attribute(Player.Attributes.ROUNDS)))
	return text

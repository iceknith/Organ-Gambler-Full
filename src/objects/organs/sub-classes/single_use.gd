class_name SingleUseOrgan extends Organ

func _on_round_ended():
	remove.emit()

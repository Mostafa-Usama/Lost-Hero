extends VBoxContainer

signal close

func _on_button_pressed():
	Globals.minDamage = round(Globals.minDamage * 1.4)
	Globals.maxDamage = round(Globals.maxDamage * 1.4)
	close.emit()

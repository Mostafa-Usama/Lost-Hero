extends VBoxContainer

signal close

func _on_button_pressed():
	Globals.critChance += .1
	close.emit()

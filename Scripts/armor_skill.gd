extends VBoxContainer


signal close

func _on_button_pressed():
	Globals.armor += .1
	close.emit()

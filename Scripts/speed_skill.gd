extends VBoxContainer

signal close

func _on_button_pressed():
	Globals.speed += 10
	close.emit()

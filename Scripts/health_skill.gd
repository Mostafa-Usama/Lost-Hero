extends VBoxContainer

signal close
# Called when the node enters the scene tree for the first time.


func _on_button_pressed():
	Globals.playerMaxHealth += 5
	Globals.playerCurrentHealth = Globals.playerMaxHealth
	close.emit()

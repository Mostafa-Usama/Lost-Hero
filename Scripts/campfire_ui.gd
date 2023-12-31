extends CanvasLayer
@export var player_inv : inventory
@export var wood : invItem
@export var meat : invItem
@export var cookedMeat :invItem

signal close

func _on_button_pressed():
	#var rec = "meat"
	if player_inv.haveItems(wood, 1) and player_inv.haveItems(meat, 1):
		player_inv.consumeItems(wood, 1)
		player_inv.consumeItems(meat, 1)
		player_inv.insert(cookedMeat)


func _on_texture_button_pressed():
	close.emit()

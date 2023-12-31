extends Resource

class_name  inventory

@export var slots: Array[inventory_slot]
#var inv = load("res://Scenes/inventory_ui.tscn")
func insert(items:invItem):
	var stored = false
	for i in range(slots.size()):
		if slots[i].item == items:
			if slots[i].amount < 9:
				slots[i].amount +=1
				stored = true
				break
	if not stored:				
		for i in range(slots.size()):
			if not slots[i].item :
				slots[i].item = items
				slots[i].amount =1
				break
func haveItems(it:invItem, amount):
	
	for i in range(slots.size()):
		if slots[i].item:
			if slots[i].item.name == it.name and slots[i].amount >= amount:
				return true
	return false

func consumeItems(it:invItem, amount):
	for i in range(slots.size()):
		if slots[i].item:
			if slots[i].item.name == it.name:
				slots[i].amount -= amount

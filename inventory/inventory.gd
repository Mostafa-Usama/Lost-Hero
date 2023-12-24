extends Resource

class_name  inventory

@export var slots: Array[inventory_slot]
#var inv = load("res://Scenes/inventory_ui.tscn")
func insert(items:invItem):
	for i in range(slots.size()):
		if slots[i].item == items:
			if slots[i].amount < 9:
				slots[i].amount +=1
				break
		if not slots[i].item :
			slots[i].item = items
			slots[i].amount =1
			break

func use(it:invItem, amount):
	
	for i in range(slots.size()):
		if slots[i].item:
			if slots[i].item.name == it.name and slots[i].amount >= amount:
				slots[i].amount -= amount
				#inv.uodate()
				return true
	return false

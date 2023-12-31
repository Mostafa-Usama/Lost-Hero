extends Control


@onready var _inventory:inventory 
@onready var player_inventory:inventory = preload("res://inventory/inventories/player_inventory.tres")
@onready var slots: Array = $Background/GridContainer.get_children()
@onready var itemGuiInstance = preload("res://Scenes/ItemGui.tscn")

var items: Array[invItem]
var current_items :Array[invItem]
var num_of_items
var capacity
var least
signal empty

func _on_chest_inv(new_inv, rewards, cap, num):
	_inventory = new_inv
	items = rewards
	capacity = cap
	least = num
	visible = false
	num_of_items = randi_range(least, capacity)
	for i in range(num_of_items):
		var rand :invItem = items.pick_random()
		current_items.push_back(rand)
		_inventory.insert(rand)		
	update_slots()
	
func update_slots():
	for i in range(_inventory.slots.size()):
		if (_inventory.slots[i].item):
			#var it:item_gui = slots[i].itemGui
			if not slots[i].itemGui:
				slots[i].itemGui = itemGuiInstance.instantiate()
				slots[i].insert(slots[i].itemGui)
			slots[i].itemGui.slot = _inventory.slots[i]
			slots[i].itemGui.update()

func _on_chest_collect_items():
	collect()

func collect():
	for i in range(current_items.size()):
		_inventory.consumeItems(current_items[i], 1)
		player_inventory.insert(current_items[i])
	
	empty.emit()
	current_items.clear()
	update_slots()

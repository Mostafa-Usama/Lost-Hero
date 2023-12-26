extends Control

var opened = false
@onready var _inventory:inventory = preload("res://inventory/inventories/player_inventory.tres")
@onready var slots: Array = $Background/GridContainer.get_children()
@onready var itemGuiInstance = preload("res://Scenes/ItemGui.tscn")
# Called when the node enters the scene tree for the first time.
var itemInHand : item_gui
func update_slots():
	for i in range(_inventory.slots.size()):
		if (_inventory.slots[i].item):
			#var it:item_gui = slots[i].itemGui
			if not slots[i].itemGui:
				slots[i].itemGui = itemGuiInstance.instantiate()
				slots[i].insert(slots[i].itemGui)
			slots[i].itemGui.slot = _inventory.slots[i]
			slots[i].itemGui.update()
		
func _ready():
	update_slots()
	close()
	connectSlots()
	
func connectSlots():
	
	for i in range(slots.size()):
		var callable = Callable(_on_slot_gui_input)
		callable = callable.bind(_inventory.slots[i],slots[i], i)
		slots[i].gui_input.connect(callable)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	update_slots()
	if Input.is_action_just_pressed("open"):
		if opened:
			close()
		else:
			open()

func close():
	opened = false
	visible = false
	
func open():
	opened = true
	visible = true
	
func _on_slot_gui_input(event,inv_slot:inventory_slot ,slot, i):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:	
		if event.double_click and inv_slot.item:
			if inv_slot.item.name == "Apple":
				_inventory.use(inv_slot.item, 1)
				Globals.hunger += 5
				Globals.playerCurrentHealth += 2
				update_slots()
				
		#elif event.pressed:
			#if slot.isEmpty() and itemInHand:
				#insertItem(slot)
				#return
			#if not itemInHand and inv_slot.item:
				#takeItemInHand(slot)
			#else: return
			#
#func insertItem(slot):
	#var it = itemInHand
	#remove_child(itemInHand)
	#itemInHand = null	
	#slot.insert(it)
			#
#func takeItemInHand(slot):
	#itemInHand = slot.takeItem()
	#add_child(itemInHand)
	#moveItemInHand()
	#
#func moveItemInHand():
	#if not itemInHand: return
	#itemInHand.global_position = get_global_mouse_position() - itemInHand.size/2
#
#func _input(event):
	#moveItemInHand()

extends Control

var opened = false
@onready var _inventory:inventory = preload("res://inventory/inventories/player_inventory.tres")
@onready var slots: Array = $Background/GridContainer.get_children()
@onready var itemGuiInstance = preload("res://Scenes/ItemGui.tscn")
# Called when the node enters the scene tree for the first time.

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
		var call = Callable(_on_slot_gui_input)
		call = call.bind(_inventory.slots[i],slots[i], i)
		slots[i].gui_input.connect(call)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#for i in range(_inventory.slots.size()):
		#if slots[i].itemGui:
			#slots[i].itemGui.update(_inventory.slots[i])
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
		if event.double_click:
			if inv_slot.item:
				if inv_slot.item.name == "Apple":
					_inventory.use(inv_slot.item, 1)
					Globals.hunger += 5
					Globals.playerCurrentHealth += 2
					update_slots()
			



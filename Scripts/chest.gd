extends StaticBody2D

@export var _inventory:inventory 
@export var items: Array[invItem]
@export var capacity: int
@export var least : int
var near = false
var opened = false
var collect = false
signal collect_items

signal inv(new_inv, rewards, capacity, least)
# Called when the node enters the scene tree for the first time.
func _ready():
	inv.emit(_inventory, items, capacity, least)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("action") and near:
		if not opened:
			$AnimatedSprite2D.play("opened")
		opened = true
		collect = true
		$"Chest Inventory".visible = true
		
	if not near:
		$"Chest Inventory".visible = false

func _input(event):
	if event.is_action_pressed("action") and collect:
		print("collected")
		collect_items.emit()
		
func _on_open_area_body_entered(_body):
	near = true


func _on_open_area_body_exited(_body):
	near = false
	collect = false


func _on_chest_inventory_empty():
	$AnimatedSprite2D.play("empty")

extends Panel
class_name item_gui

var slot: inventory_slot

@onready var itemSprite : Sprite2D = $item
@onready var amount:Label = $amount
# Called when the node enters the scene tree for the first time.

func update():
	if !slot or !slot.item:
		return
	itemSprite.texture = slot.item.texture
	if slot.amount >= 1:
		$amount.text = str(slot.amount)
	elif slot.amount == 0:
		slot.item = null
		itemSprite.texture = null
		$amount.text=""
		queue_free()

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

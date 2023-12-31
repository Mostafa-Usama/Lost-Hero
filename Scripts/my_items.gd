extends Control

@onready var slots: Array = $Background/GridContainer.get_children()
var allSlots
		
func update_slots():
	for i in range(12):
		if allSlots[i].get_child(0).get_child_count() == 1:
			var child = allSlots[i].get_child(0).get_child(0)
			if slots[i].get_child(0).get_child_count() == 0:
				var panel = create_node(child)
				slots[i].get_child(0).add_child(panel)
			else:
				slots[i].get_child(0).get_child(0).get_child(1).text = child.get_child(1).text 
		else:
			if slots[i].get_child(0).get_child_count() == 1:
				var child = slots[i].get_child(0).get_child(0)
				slots[i].get_child(0).remove_child(child)

func create_node(child):
	var panel = Panel.new()
	var sprite = Sprite2D.new()
	var label = Label.new()
	sprite.texture = child.get_node('item').texture
	label.text = child.get_child(1).text
	label.scale = Vector2(.4,.4)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	label.size = Vector2(18,10)
	panel.add_child(sprite)
	panel.add_child(label)
	return panel
					
func _ready():
	allSlots = get_parent().get_parent().get_parent().get_parent().get_node("Player").get_child(5).get_child(0).get_child(0).get_children()        

func _process(_delta):
	update_slots()

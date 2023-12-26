extends TextureButton	

#@onready var itemSprite : Sprite2D = $CenterContainer/Panel/item
@onready var container: CenterContainer = $CenterContainer
var itemGui: item_gui
#func takeItem():
	#var it = itemGui
	#print(container.get_children())
	#container.remove_child(itemGui)
	#print(container.get_children())
	#itemGui = null
	#return it
	
func insert(it:item_gui):
	container.add_child(it)

func isEmpty():
	return !itemGui

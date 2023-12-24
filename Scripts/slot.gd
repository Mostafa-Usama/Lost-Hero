extends TextureButton	

#@onready var itemSprite : Sprite2D = $CenterContainer/Panel/item
@onready var container: CenterContainer = $CenterContainer
var itemGui: item_gui
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func insert(it:item_gui):
	container.add_child(it)


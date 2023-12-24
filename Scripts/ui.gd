extends CanvasLayer

var coins_opened = false
@onready var coins =$coins
# Called when the node enters the scene tree for the first time.
func _ready():
	coins.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_released("open"):
		coins.visible = !coins_opened
		coins_opened = !coins_opened 
		$coins/HBoxContainer/coins.text = str(Globals.coins)
		
	$"Health/Health bar".max_value = Globals.playerMaxHealth
	$"Health/Health bar/Health".text = str(Globals.playerCurrentHealth) +"/"+str(Globals.playerMaxHealth)
	$"Health/Health bar".value = Globals.playerCurrentHealth
	$"Character/NinePatchRect/XP bar/XP label".text = str(Globals.currentXp) +"/"+str(Globals.maxXP)
	$"Character/NinePatchRect/XP bar".value = Globals.currentXp
	$"Character/NinePatchRect/XP bar".max_value = Globals.maxXP
	$"Character/NinePatchRect/Level label".text = "Level: " + str(Globals.currentLevel)
	$"Character/NinePatchRect/Hunger Bar".max_value = Globals.maxHunger
	$"Character/NinePatchRect/Hunger Bar/Hunger Label".text = str(Globals.hunger) +"/"+str(Globals.maxHunger)
	$"Character/NinePatchRect/Hunger Bar".value = Globals.hunger


func _on_hunger_timer_timeout():
	Globals.hunger -= 1

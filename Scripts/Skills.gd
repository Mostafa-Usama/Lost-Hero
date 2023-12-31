extends HBoxContainer

@onready var health:PackedScene = preload("res://Scenes/health_skill.tscn")
@onready var speed:PackedScene = preload("res://Scenes/speed_skill.tscn")
@onready var luck:PackedScene = preload("res://Scenes/luck_skill.tscn")
@onready var damage:PackedScene = preload("res://Scenes/damage_skill.tscn")
@onready var armor:PackedScene = preload("res://Scenes/armor_skill.tscn")
@onready var skills : Array[PackedScene] = [health, speed, luck, damage, armor]
var lvl = 1

func _process(_delta):
	if Globals.currentLevel != lvl:
		lvl = Globals.currentLevel
		pick_skills()	

func pick_skills():

	var picked = []
	for i in range(3):
		var rand = skills.pick_random()
		while rand in picked:
			rand =  skills.pick_random()
		var skill = rand.instantiate() 
		add_child(skill)
		#connect_sginals(skill)
		skill.connect("close", close)
		picked.push_back(rand)
	picked.clear()

func close():
	$"../..".visible = false
	$"../../../Character/Level Up Button".visible = false
	$"../../../Character/Level Up Button".disabled = true
	for child in get_children():
		child.queue_free()

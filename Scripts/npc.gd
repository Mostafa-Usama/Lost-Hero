extends CharacterBody2D
class_name npc

var player
var speed = 80
var dir = [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]
var player_around = false
var player_state = "idle"
var ani
var direction
var talking = false
var quest_finished = false
var talked = false
var finished_talking = false
@export var quest_item :invItem
@export var amount :int
@export var player_inv: inventory
@export var quest_num:Array[int]
@export var prize:int
@export var xp:int
signal num(number:int)
signal finshed
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_parent().find_child("Player")
	ani = $AnimatedSprite2D as AnimatedSprite2D
	var number = quest_num.find(1)
	num.emit(number)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if ani:
		if player_state == "idle" or talking:
			ani.play("idle")
	
	#if player_state == "walking" and not talking:
		#if direction == Vector2.RIGHT:
			#ani.play("walk_right")
		#if direction == Vector2.LEFT:
			#ani.play("walk_left")
		#if direction == Vector2.UP:
			#ani.play("walk_up")
		#if direction == Vector2.DOWN:
			#ani.play("walk_down")
		#velocity = direction * speed
		#move_and_slide()

func quest():
	print(player_inv.haveItems(quest_item, amount))
	return  player_inv.haveItems(quest_item, amount)

func _input(event):
	if event.is_action_pressed("action") and not talking and player_around:
		if talked:
			if (not quest_finished) and quest():
				player_inv.consumeItems(quest_item, amount)
				Globals.currentXp += xp
				quest_finished = true
				finshed.emit()
				Globals.coins += prize
		finished_talking = false
		talked = true	
		talking = true
		$Dialogue.start() 
		
	elif event.is_action_pressed("action") and finished_talking :
		talking = false
		
#func _on_timer_timeout():
	#direction = dir.pick_random()
	#player_state = "walking"
	#$move.start()
#

#func _on_move_timeout():
	#player_state = "idle"
#

func _on_interact_area_body_entered(_body):
	player_around = true


func _on_interact_area_body_exited(_body):
	player_around = false
	talking = false
	$Dialogue.visible = false
	$Dialogue.active =  false
	$Dialogue.current_dialogue = 0

func _on_dialogue_finshed():
	finished_talking = true


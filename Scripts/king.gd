extends npc

var arrived = false

@onready var queen = get_parent().find_child("queen")
func _process(_delta):
	if ani:
		if  finished_talking and not arrived:
			queen.rescued = true
			$AnimatedSprite2D.play("walk")
			var player_dir = (player.global_position - position).normalized()
			velocity = speed * player_dir
			look_at_player()
			move_and_slide()
	
		elif player_state == "idle" or talking:
			ani.play("idle")
			
		if player_around and Input.is_action_just_pressed("action") and not talking and not finished_talking:
			talking = true
			$Dialogue.start() 
		

func _input(event):
	if event.is_action_pressed("action") and (not talked or arrived) and player_around:
		if talked:
			if (not quest_finished) and quest():
				quest_finished = true
				finshed.emit()
		finished_talking = false
		talked = true	
		talking = true
		$Dialogue.start() 
		
	elif event.is_action_pressed("action") and finished_talking :
		talking = false		

func look_at_player():
	var dir = rad_to_deg( ((player.global_position-global_position).normalized()).angle())
	if dir < 0:
		dir += 360
	if dir >= 90 and dir < 270:
		$AnimatedSprite2D.flip_h = true
	else:	
		$AnimatedSprite2D.flip_h = false
		
func quest():
	return arrived

extends CharacterBody2D

var speed = 80
var health = 20
var damage = 3
var dir = [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]
var player_around = false
var player = null
var attacking = false
var dead= false
var canAttack =true
var xp = 5
@export var loot:invItem

var player_state = "idle"
var ani
var direction
var direction_anim
# Called when the node enters the scene tree for the first time.
func _ready():
	ani = $AnimatedSprite2D as AnimatedSprite2D
	$Control.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Control/TextureProgressBar.value = health
	if not dead:
		if player_around and not attacking:
			direction_anim = rad_to_deg( ((player.global_position - position).normalized()).angle())
			var player_dir = (player.global_position - position).normalized()
			move_anim(direction_anim)
			velocity = speed * player_dir
			move_and_slide()
			
		elif attacking:
			if canAttack:

				attatck_anim(direction_anim)
				var dmg = damage - (round(damage * Globals.armor))
				player.hit(dmg)
				canAttack = false
				$Timer.start()
			
		elif player_state == "idle":
			ani.play("idle")
		elif player_state == "walking":
			if direction == Vector2.RIGHT:
				ani.play("right_walk")
			if direction == Vector2.LEFT:
				ani.play("left_walk")
			if direction == Vector2.UP:
				ani.play("up_walk")
			if direction == Vector2.DOWN:
				ani.play("down_walk")
			velocity = direction * speed
			move_and_slide()

func hit(dmg):
	
	$Control.visible = true
	health -= dmg

	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D,"modulate", Color.RED,.2)
	tween.tween_property($AnimatedSprite2D,"modulate", Color.WHITE,.2)
	if health <= 0:
		dead = true
		Globals.currentXp += xp
		ani.play("death")
		$CollisionShape2D.queue_free()
		await ani.animation_finished
		$Control.visible = false
		$"meat loot".visible = true
		
func move_anim(dir):
	if dir < 0:
		dir +=360
	if dir > 342.5 or (dir >= 0 and dir <= 22.5):
		$AnimatedSprite2D.play("right_walk")	
	if dir > 22.5 and dir <= 67.5:
		$AnimatedSprite2D.play("down_right_walk")
	if dir > 67.5 and dir <= 112.5:
		$AnimatedSprite2D.play("down_walk")
	if dir > 112.5 and dir <= 157.5:
		$AnimatedSprite2D.play("down_left_walk")
	if dir > 157.5 and dir <= 202.5:
		$AnimatedSprite2D.play("left_walk")
	if dir > 202.5 and dir <= 247.5:
		$AnimatedSprite2D.play("up_left_walk")
	if dir > 247.5 and dir <= 292.5:
		$AnimatedSprite2D.play("up_walk")
	if dir > 292.5 and dir < 342.5:
		$AnimatedSprite2D.play("up_right_walk")									
	
func attatck_anim(dir):
	player_state = "attack"
	if dir < 0:
		dir +=360
	if dir > 315 or (dir >= 0 and dir <= 45):
		$AnimatedSprite2D.play("right_attack")	
	#if dir > 22.5 and dir <= 67.5:
		#$AnimatedSprite2D.play("down_right_attack")
	if dir > 45 and dir <= 135:
		$AnimatedSprite2D.play("down_attack")
	#if dir > 112.5 and dir <= 157.5:
		#$AnimatedSprite2D.play("down_left_attack")
	if dir > 135 and dir <= 225:
		$AnimatedSprite2D.play("left_attack")
	#if dir > 202.5 and dir <= 247.5:
		#$AnimatedSprite2D.play("up_left_attack")
	if dir > 225 and dir <= 315:
		$AnimatedSprite2D.play("up_attack")
	#if dir > 292.5 and dir < 342.5:
		#$AnimatedSprite2D.play("up_right_attack")									
	await  $AnimatedSprite2D.animation_finished
	player_state = ""
	

func _on_delay_timeout():
	if not player_around:
		direction = dir.pick_random()
		player_state = "walking"
		$move.start()

func _on_move_timeout():
	player_state = "idle"


func _on_notice_area_body_entered(body):
	player_around = true
	player = body


func _on_attack_area_body_entered(_body):
	attacking = true


func _on_attack_area_body_exited(_body):
	attacking = false


func _on_timer_timeout():
	canAttack = true


func _on_meat_loot_body_entered(body):
	body.collect(loot)
	queue_free()

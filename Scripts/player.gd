extends CharacterBody2D

var speed = 100
var player_state
@export var player_inventory: inventory
var bow_equiped = true
var canShoot = true
var arrows = preload("res://Scenes/arrow.tscn")
var collect_text = preload("res://Scenes/collect_text.tscn")
var dead = false
@onready var col = $CollisionShape2D

func _physics_process(_delta):
	if Globals.currentXp >= Globals.maxXP:
		$AnimationPlayer.play("level_up")
	if Globals.hunger <= 0 and not dead:
		dead = true
		$AnimatedSprite2D.play("death")
	if not dead:
		var direction = Input.get_vector("left", "right", "up", "down")
		
		if player_state != "attack":
			if direction == Vector2.ZERO:
				player_state = "idle"
			else:
				player_state = "walk"
			player_anim(direction)
		
		velocity = direction * speed
		move_and_slide()
		
		var mos_pos = get_global_mouse_position()
		
		$ShootingPos.look_at(mos_pos)
		if Input.is_action_pressed("shot") and bow_equiped and canShoot:
			var mouse_direction = rad_to_deg( ((mos_pos-position).normalized()).angle())
			canShoot= false
			var arrow = arrows.instantiate() as Area2D
			arrow.global_position = $ShootingPos.global_position
			arrow.rotation = $ShootingPos.rotation
			add_child(arrow)
			player_attack_ainm(mouse_direction)
			await get_tree().create_timer(.6).timeout
			canShoot = true

func hit(damage, type=null):
	Globals.playerCurrentHealth -= damage
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D,"modulate", Color.RED,.2)
	tween.tween_property($AnimatedSprite2D,"modulate", Color.WHITE,.2)
	if Globals.playerCurrentHealth <= 0:
		if col:
			col.disabled = true
		Globals.playerCurrentHealth = 0
		dead = true
		$AnimatedSprite2D.play("death")
		return
	if type == "fire":
		$GPUParticles2D.emitting = true
		await get_tree().create_timer(2).timeout
		hit(1)
		if Globals.playerCurrentHealth <= 0:
			if col:
				col.disabled = true
			Globals.playerCurrentHealth = 0
			dead = true
			$AnimatedSprite2D.play("death")
			return
		await get_tree().create_timer(2).timeout
		hit(1)
		$GPUParticles2D.emitting = false
	if Globals.playerCurrentHealth <= 0:
		if col:
			col.disabled = true
		Globals.playerCurrentHealth = 0
		dead = true
		$AnimatedSprite2D.play("death")
		return
	
func player_attack_ainm(dir):
	player_state = "attack"

	if dir < 0:
		dir +=360
	if dir > 342.5 or (dir >= 0 and dir <= 22.5):
		$AnimatedSprite2D.play("righ_attack")	
	if dir > 22.5 and dir <= 67.5:
		$AnimatedSprite2D.play("down_right_attack")
	if dir > 67.5 and dir <= 112.5:
		$AnimatedSprite2D.play("down_attack")
	if dir > 112.5 and dir <= 157.5:
		$AnimatedSprite2D.play("down_left_attack")
	if dir > 157.5 and dir <= 202.5:
		$AnimatedSprite2D.play("left_attack")
	if dir > 202.5 and dir <= 247.5:
		$AnimatedSprite2D.play("up_left_attack")
	if dir > 247.5 and dir <= 292.5:
		$AnimatedSprite2D.play("up_attack")
	if dir > 292.5 and dir < 342.5:
		$AnimatedSprite2D.play("up_right_attack")									
	await  $AnimatedSprite2D.animation_finished
	player_state = ""
	
func player_anim(dir):
	if player_state == "idle":
		$AnimatedSprite2D.play("idle")
	if player_state == "walk":
		if dir.y == 1:
			$AnimatedSprite2D.play("down_walk")
		if dir.y == -1:
			$AnimatedSprite2D.play("up_walk")
		if dir.x == 1:
			$AnimatedSprite2D.play("right_walk")
		if dir.x == -1:
			$AnimatedSprite2D.play("left_walk")
		if dir.x > 0.5 and dir.y < -0.5:
			$AnimatedSprite2D.play("up_right_walk")
		if dir.x > 0.5 and dir.y > 0.5:
			$AnimatedSprite2D.play("down_right_walk")
		if dir.x < -0.5 and dir.y > 0.5:
			$AnimatedSprite2D.play("down_left_walk")
		if dir.x < -0.5 and dir.y < -0.5:
			$AnimatedSprite2D.play("up_left_walk")
	
func collect(i: invItem):
	var Ctext = collect_text.instantiate()
	Ctext.text = str("+1 " + i.name)
	add_child(Ctext)
	player_inventory.insert(i)
	
	#$Inventory_UI.update_slots()


func _on_red_worker_npc_finshed():
	#$Inventory_UI.update_slots()
	pass

extends CharacterBody2D

var attack = false
var canHit = true
var dead = false
var player 
var player_around=  false
var damage = 3
var health = 15
var xp = 4
var move = true
var speed = 90
@export var quest: bool
var farmer
# Called when the node enters the scene tree for the first time.
func _ready():
	farmer = get_parent().get_parent().find_child("NPCs").find_child("farmer")
	player = get_parent().get_parent().find_child("Player")
	$Control.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Control/TextureProgressBar.value = health
	if not dead:
		if attack and canHit:
			move = false
			$Timer.start()
			$AnimatedSprite2D.play("attack")
			canHit= false
			await get_tree().create_timer(.4).timeout
			var dmg = damage - (round(damage * Globals.armor))
			player.hit(dmg)
			await $AnimatedSprite2D.animation_finished
			move = true
		elif player_around and move :
			look_at_player()
			$AnimatedSprite2D.play("run")
			var player_dir = (player.global_position - position).normalized()
			velocity = speed * player_dir
			move_and_slide()
			
		if not player_around:
			$AnimatedSprite2D.play("idle")
			pass

func look_at_player():
	var dir = rad_to_deg( ((player.global_position-global_position).normalized()).angle())
	if dir < 0:
		dir += 360
	if dir >= 90 and dir < 270:
		$AnimatedSprite2D.flip_h = false

	else:	
		$AnimatedSprite2D.flip_h = true
		
		
func hit(dmg):
	$Control.visible = true
	health -= dmg
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D,"modulate", Color.RED,.2)
	tween.tween_property($AnimatedSprite2D,"modulate", Color.WHITE,.2)
	if health <= 0 and not dead:
		if quest:
			farmer.wolves_count += 1
			print(farmer.wolves_count)
		dead = true
		Globals.currentXp += xp
		$AnimatedSprite2D.play("death")
		$CollisionShape2D.queue_free()
		await $AnimatedSprite2D.animation_finished
		queue_free()
		#$"slime loot".visible = true

func _on_notice_area_body_entered(_body):
	player_around = true


func _on_notice_area_body_exited(_body):
	player_around = false


func _on_attack_area_body_entered(_body):
	attack = true


func _on_attack_area_body_exited(_body):
	attack = false


func _on_timer_timeout():
	canHit = true

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
var speed = 70
@onready var ray = $RayCast2D
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_parent().find_child("Player")
	$Control.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Control/TextureProgressBar.value = health
	if not dead:
		ray.target_position  = to_local(player.position)
		if attack and canHit:
			move = false
			$Timer.start()
			$AnimatedSprite2D.play("attack")
			canHit= false
			await get_tree().create_timer(.4).timeout
			player.hit(damage)
			await $AnimatedSprite2D.animation_finished
			move = true
		elif ray.get_collider() == player and player_around and move :
			look_at_player()
			$AnimatedSprite2D.play("walk")
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
		$AnimatedSprite2D.flip_h = true

	else:	
		$AnimatedSprite2D.flip_h = false


	
func hit(dmg):
	$Control.visible = true
	health -= dmg
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D,"modulate", Color.RED,.2)
	tween.tween_property($AnimatedSprite2D,"modulate", Color.WHITE,.2)
	if health <= 0 and not dead:
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
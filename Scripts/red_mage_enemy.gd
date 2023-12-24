extends CharacterBody2D

var fireball = preload("res://Scenes/fireball_attaack.tscn")
var canShoot = true
var dead = false
var player 
var player_around=  false
var health = 15
var xp = 5
var shooting
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
		if canShoot and ray.get_collider() == player and player_around:
			shooting = look_at_player()
			$Timer.start()
			$AnimatedSprite2D.play("attack")
			var player_pos = player.global_position
			shooting.look_at(player_pos)
			canShoot= false
			var fire = fireball.instantiate() as Area2D
			fire.global_position = shooting.global_position
			fire.rotation = shooting.rotation
			add_child(fire)
		else:
			$AnimatedSprite2D.play("idle")


func look_at_player():
	var dir = rad_to_deg( ((player.global_position-global_position).normalized()).angle())
	if dir < 0:
		dir += 360
	if dir >= 90 and dir < 270:
		$AnimatedSprite2D.flip_h = true
		return $ShootingPos2
	else:	
		$AnimatedSprite2D.flip_h = false
		return $ShootingPos
		
func hit(damage):
	$Control.visible = true
	health -= damage
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D,"modulate", Color.RED,.2)
	tween.tween_property($AnimatedSprite2D,"modulate", Color.WHITE,.2)
	if health <= 0 and not dead:
		dead = true
		Globals.currentXp += xp
		$AnimatedSprite2D.play("die")
		$CollisionShape2D.queue_free()
		await $AnimatedSprite2D.animation_finished
		queue_free()
		#$"slime loot".visible = true
		

func _on_notice_area_body_entered(_body):
	player_around = true
	


func _on_notice_area_body_exited(_body):
	player_around = false
	

func _on_timer_timeout():
	canShoot = true

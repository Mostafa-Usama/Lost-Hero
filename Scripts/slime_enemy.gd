extends CharacterBody2D
var damage = 1
var speed = 70
var health = 10
var player_around = false
var player = null
var attacking = false
var dead= false
var canAttack =true
var xp = 2
@export var loot:invItem 
@onready var aniSprite = $AnimatedSprite2D as AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	$Control.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Control/TextureProgressBar.value = health
	if not dead:
		if player_around and not attacking:
			var dir = (player.global_position - global_position).normalized()
			
			aniSprite.play("follow")
			velocity = speed * dir
			move_and_slide()
		else:
			aniSprite.play("idle")
			
		if attacking:
			if canAttack:
				player.hit(damage)
				canAttack = false
				$Timer.start()
			
func _on_notice_area_body_entered(body):
	player_around = true
	player = body

func _on_notice_area_body_exited(_body):
	player_around = false


func _on_attack_area_body_entered(_body):
	attacking = true

	
func _on_attack_area_body_exited(_body):
	attacking = false

func hit(dmg):
	$Control.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D,"modulate", Color.RED,.2)
	tween.tween_property($AnimatedSprite2D,"modulate", Color.WHITE,.2)
	health -= dmg
	if health <= 0 and not dead:
		dead = true
		Globals.currentXp += xp
		aniSprite.play("death")
		$CollisionShape2D.queue_free()
		await aniSprite.animation_finished
		$Control.visible = false
		$"slime loot".visible = true
		
		


func _on_slime_loot_body_entered(body):
	body.collect(loot)
	print("Collected slime")
	queue_free()




func _on_timer_timeout():
	canAttack = true

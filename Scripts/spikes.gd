extends Area2D

var damage = 2
var player_around = false
var player
var active = false
var canHit = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if active and player and canHit:
		player.hit(damage)
		canHit = false

func _on_body_entered(body):
	player = body
	player_around = true

func _on_body_exited(_body):
	player = null
	player_around = false


func _on_opened_timeout():
	active = true
	canHit = true
	$AnimatedSprite2D.play("opened")
	$closed.start()



func _on_closed_timeout():
	active = false
	canHit = false
	$AnimatedSprite2D.play("closed")
	$opened.start()
	


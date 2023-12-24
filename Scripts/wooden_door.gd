extends StaticBody2D

var player_around = false
var opened = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player_around and Input.is_action_just_pressed("action") and not opened:
		$AnimatedSprite2D.play("opened")
		$closed.queue_free()
		$opened.disabled = false
		$opened2.disabled = false	
		opened = true
	
func _on_interact_area_body_entered(_body):
	player_around = true


func _on_interact_area_body_exited(_body):
	player_around = false

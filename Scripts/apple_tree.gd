extends StaticBody2D

var grown = false
var playerInArea = false
var apple = preload("res://Scenes/apple.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("not_grown")
	$Growth_time.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if grown:
		$AnimatedSprite2D.play("Grown")
	if playerInArea and Input.is_action_pressed("action") and grown:
		$AnimatedSprite2D.play("not_grown")
		$Growth_time.start()
		grown = false
		dropApple()
	
func _on_growth_time_timeout():
	grown = true


func _on_pick_range_body_entered(_body):
	playerInArea = true


func _on_pick_range_body_exited(_body):
	playerInArea = false

func dropApple():
	var apple_instance = apple.instantiate() 
	add_child(apple_instance)
	apple_instance.position = Vector2.ZERO

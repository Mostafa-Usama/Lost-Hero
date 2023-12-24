extends Area2D

var speed = 300
var damage = 4
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += (Vector2.RIGHT * speed).rotated(rotation) * delta


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.has_method("hit"):
		body.hit(damage)
	queue_free()

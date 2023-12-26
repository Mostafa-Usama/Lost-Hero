extends Area2D

var speed = 200
var damage = 3
var type = "fire"
var hit = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not hit:
		position += (Vector2.RIGHT * speed).rotated(rotation) * delta


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	hit = true
	global_rotation += 90
	if body.has_method("hit"):
		var dmg = damage - (round(damage * Globals.armor))
		body.hit(dmg, type)
	$Sprite2D.play("explode")
	await $Sprite2D.animation_finished
	queue_free()

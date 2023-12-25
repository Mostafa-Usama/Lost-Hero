extends Area2D

var speed = 300
var hit = false
#var damage = 4
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
	if body.has_method("hit"):
		var dmg = randi_range(Globals.minDamage, Globals.maxDamage)
		hit = true
		var crit = randf()
		if crit <= Globals.critChance:
			dmg = round(Globals.maxDamage * 1.5)
			$Label.self_modulate = Color.RED
			$Label.scale = Vector2(1, 1)
		$Label.text = str(dmg)
		$Label.rotation_degrees = -rotation_degrees
		body.hit(dmg)
		$AnimationPlayer.play("text_move")
		$Sprite2D.queue_free()
		$CollisionShape2D.queue_free()
		await $AnimationPlayer.animation_finished
		
	queue_free()

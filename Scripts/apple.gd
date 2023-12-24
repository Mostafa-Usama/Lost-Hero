extends item
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("drop")

func _on_pickup_area_body_entered(body):
	body.collect(itemType)
	queue_free()

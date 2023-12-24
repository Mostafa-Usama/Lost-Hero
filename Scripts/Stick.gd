extends item

var player = null
func _process(_delta):
	if Input.is_action_pressed("action") and playerInArea:
		player.collect(itemType)
		queue_free()
	
func _on_pickup_area_body_entered(body):
	playerInArea = true
	player = body

func _on_pickup_area_body_exited(_body):
	playerInArea = false

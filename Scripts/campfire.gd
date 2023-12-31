extends StaticBody2D

var around = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("action") and around:
		$"Campfire UI".visible = !$"Campfire UI".visible


func _on_open_range_body_entered(_body):
	around =true


func _on_open_range_body_exited(_body):
	around = false
	$"Campfire UI".visible = false


func _on_campfire_ui_close():
	$"Campfire UI".visible = false

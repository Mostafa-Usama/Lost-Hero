extends Node2D

var player_cam
var day = true
var dungeon = false
var rainChance = 0.2
# Called when the node enters the scene tree for the first time.
func _ready():
	player_cam = get_child(1, true).get_child(2) as Camera2D
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
		$DirectionalLight2D.visible = not dungeon
		$DirectionalLight2D2.visible = dungeon	

func _on_down_body_entered(_body):
	player_cam.limit_top = 252
	player_cam.limit_bottom = 590


func _on_return_down_body_entered(_body):
	player_cam.limit_top = -276
	player_cam.limit_bottom = 275


func _on_day_cycle_timeout():
	
	if day:
		$AnimationPlayer.play("day cycle")
		if randf() <= rainChance:
			$Rain/CPUParticles2D.emitting = true
	else:
		$Rain/CPUParticles2D.emitting = false
		$AnimationPlayer.play_backwards("day cycle")
	day = !day


func _on_left_body_entered(_body):
	player_cam.limit_left = -441
	player_cam.limit_right= 398


func _on_return_left_body_entered(_body):
	player_cam.limit_left = -1070
	player_cam.limit_right = -441


func _on_left_2_body_entered(_body):
	player_cam.limit_top = -276
	player_cam.limit_bottom = 275

func _on_return_left_2_body_entered(_body):
	player_cam.limit_bottom = -276
	player_cam.limit_top = -670
	dungeon = false


func _on_return_up_2_body_entered(_body):
	dungeon = true
	player_cam.limit_bottom = -690
	player_cam.limit_top = -1110
	player_cam.limit_left = -1070
	player_cam.limit_right = -370


func _on_left_left_body_entered(body):
	player_cam.limit_left = -1730
	player_cam.limit_right = -1070


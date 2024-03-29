extends Control

@export_file("*.json") var d_file
var quest_num:int
var dialogue = []
var current_dialogue:int
var active = false
signal finshed
var quest_done= false
var finish = false

func _ready():
	visible = false
	
	
func start():
	dialogue = load_dialogue()
	visible = true
	active = true
	next_script()
	
	
func load_dialogue():
	var file = FileAccess.open("res://Dialoges/dialoge 1.json",FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	
	return content
	
func _input(event):
	if active:
		if event.is_action_pressed("action") and finish:
			next_script()
		elif event.is_action_pressed("action") and not finish:
			$Background/RichTextLabel2.visible_characters = len(dialogue[quest_num][current_dialogue]["text"])

func next_script():
	if quest_done:
		current_dialogue = len(dialogue[quest_num]) - 1
		$Background/RichTextLabel.text = dialogue[quest_num][current_dialogue]["name"]
		$Background/RichTextLabel2.text = dialogue[quest_num][current_dialogue]["text"]
		$Background/RichTextLabel2.visible_characters = len(dialogue[quest_num][current_dialogue]["text"])
		#current_dialogue+=1
		active = true
		visible = true
		return
	elif current_dialogue > len(dialogue[quest_num])-2:
		current_dialogue = 0
		finshed.emit()
		active = false
		visible = false
		return
		

	finish = false
	$Background/RichTextLabel.text = dialogue[quest_num][current_dialogue]["name"]
	$Background/RichTextLabel2.text = dialogue[quest_num][current_dialogue]["text"]
	$Background/RichTextLabel2.visible_characters = 0
	
	while $Background/RichTextLabel2.visible_characters < len($Background/RichTextLabel2.text):
		$Background/RichTextLabel2.visible_characters += 1
		if not active:
			finish = true
			print("here")
			return
		await get_tree().create_timer(.03).timeout
		#print(	$Background/RichTextLabel2.visible_characters)
	finish = true
	current_dialogue += 1


func _on_red_worker_npc_finshed():
	quest_done = true


func _on_red_worker_npc_num(number):
	quest_num = number


func _on_hidden():
	current_dialogue = 0
	active = false


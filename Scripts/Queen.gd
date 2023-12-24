extends npc
@onready var king = get_parent().find_child("king")
var rescued = false

func quest():
	if rescued:
		king.arrived = true
	return rescued

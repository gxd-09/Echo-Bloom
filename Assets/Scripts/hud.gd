extends Control
class_name HUD

@export var key_count_num: Label
@export var portal_status: Label

func _ready():
	portal_closed()
	

func update_key_count_num(number: int):
	key_count_num.text = str(number)
	
func portal_opened():
	portal_status.text = "Portal open!"
	
func portal_closed():
	portal_status.text = "Portal closed... Collect 10 keys!"


func _process(_delta):
	key_count_num.text = str(MyGlobal.keySum)
	if MyGlobal.keySum >= 10:
		var portal = get_tree().get_first_node_in_group("area_exits") as AreaExit
		portal.open()
		portal_opened()

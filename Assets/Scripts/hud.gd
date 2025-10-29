extends Control
class_name HUD

@export var key_count_num: Label
@export var portal_status: Label

func update_energy_cell_label(number: int):
	key_count_num.text = str(number)
	
func portal_opened():
	portal_status.text = "Portal open!"
	
func portal_closed():
	portal_status.text = "Portal closed... Collect 10 keys!"

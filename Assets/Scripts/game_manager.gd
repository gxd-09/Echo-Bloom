extends Node

var current_area = 1
var area_path = "res://Assets/Scenes/"
var num_keys = 0

func _ready():
	reset_keys()
	

func end_level():
	current_area += 1
	var full_path = area_path + "area_" + str(current_area) + ".tscn"
	get_tree().change_scene_to_file(full_path)
	print("The player has moved to the area " + str(current_area))
	
func reset_keys():
	num_keys = 0
	
func add_key():
	num_keys += 1
	if num_keys >= 3:
		var portal = get_tree().get_first_node_in_group("area_exits") as AreaExit
		portal.open()
	
func set_up_area():
	reset_keys()
	

	

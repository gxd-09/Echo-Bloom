extends Node

var current_area = 1
var area_path = "res://Assets/Scenes/"
var num_keys = 0
@onready var hud: HUD

var playerBody: CharacterBody2D

func _ready():
	await get_tree().process_frame
	if not hud:
		hud = get_tree().get_first_node_in_group("hud")
	reset_keys()
	


func end_level():
	current_area += 1
	var full_path = area_path + "area_" + str(current_area) + ".tscn"
	get_tree().change_scene_to_file(full_path)
	print("The player has moved to the area " + str(current_area))
	
func reset_keys():
	pass
	#hud.portal_closed()
	
func add_key():
	num_keys += 1
	#if is_instance_valid(hud):
	MyGlobal.keySum += 1
	MainMusic.coin_audio.play()
	#hud.update_key_count_num(num_keys)
	
	if num_keys >= 10:
		var portal = get_tree().get_first_node_in_group("area_exits") as AreaExit
		portal.open()
		#hud.portal_opened()
	
func set_up_area():
	reset_keys()
	#hud.update_key_count_num(num_keys)
	#hud.portal_closed()
	


	

extends Node2D
class_name turtle

@export var path_follow_2D: PathFollow2D
@export var path_time = 1.0
@export var ease: Tween.EaseType
@export var transition: Tween.TransitionType
@export var looping = false

func _ready():
	move_tween()
	
func move_tween():
	var tween = get_tree().create_tween().set_loops() #infinite loops by default
	#Move forward
	tween.tween_property(path_follow_2D, "progress_ratio", 1.0, path_time)
	if !looping:
		tween.tween_property(path_follow_2D, "progress_ratio", 0.0, path_time)
	else:
		tween.tween_property(path_follow_2D, "progress_ratio", 0.0, 0.0)

var dir: Vector2
func _process(_float):
	var anim_sprite = $Sprite2D2
	if dir.x == -1:
		anim_sprite.flip_h = false
	elif dir.x == 1:
		anim_sprite.flip_h = true
	

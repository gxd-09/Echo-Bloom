extends Node2D
@export var animation_player: AnimationPlayer
@onready var timer = $"dash_timer"

func start_dash(dur):
	timer.wait_time = dur
	timer.start()
	
func is_dashing():
	return !timer.is_stopped()

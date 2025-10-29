extends Area2D

@onready var timer = $Timer
@export var spike_damage = 10

func _on_body_entered(body: CharacterBody2D) -> void:
	if body is CharacterBody2D:
		print("You died")
		timer.start()
	
func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
	MyGlobal.keySum = 0

#func _on_body_entered(body: CharacterBody2D) -> void:
	#if body is Player:
		#print("damage taken")
		#body.get_parent().take_damage(spike_damage)
	#

extends Node2D

func _ready():
	$FinalMessage.visible = false


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body is CharacterBody2D:
		$Chest.play("default")
		await get_tree().create_timer(1.2).timeout
		$FinalMessage.visible = true
		

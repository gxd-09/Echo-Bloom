extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("+1 key")
		#MyGlobal.keySum += 1
		GameManager.add_key()
		queue_free()

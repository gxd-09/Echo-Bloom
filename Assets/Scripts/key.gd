extends Area2D
@onready var audio = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("+1 key")
		audio.play()
		#MyGlobal.keySum += 1
		GameManager.add_key()
		queue_free()
		

		
		#if audio.playing
			
		
		

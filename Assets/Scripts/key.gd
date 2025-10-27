extends Area2D
var sum_keys = 0

func _on_body_entered(_body: Node2D) -> void:
	print("+1 key")
	sum_keys += 1
	$KeySprite.visible = false

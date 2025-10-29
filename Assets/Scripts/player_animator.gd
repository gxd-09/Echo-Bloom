extends Node2D

@export var player_controller: Player
@export var animation_player: AnimationPlayer
@export var sprite: Sprite2D

func _process(_delta):
	#flips player based on direction (1 is right, -1 is left)
	if player_controller.direction == 1:
		sprite.flip_h = false
	elif player_controller.direction == -1:
		sprite.flip_h = true
	
	# check player is moving (negative or positive does not matter, as it is moving regardless)
	if abs(player_controller.velocity.x) > 0.0:
		animation_player.play("walk")
	else:
		animation_player.play("idle")

# jump anim - checks if velocity is in upwards direction (negative y)
	if player_controller.velocity.y < 0.0:
		animation_player.play("jump")
	

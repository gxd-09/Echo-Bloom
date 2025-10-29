extends Area2D

const damage = 20
const damage_cooldown = 1.0

var can_damage = true
@onready var damage_timer: Timer = $DamageTimer

func _ready():
	pass
	

	

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(damage)
		print("Player hit! -", damage, "health.")
		can_damage = false
		damage_timer.start(damage_cooldown)
		

func _on_damage_timer_timeout() -> void:
	can_damage = true
	print("enemy damage cooldown ready.")
	#var overlapping_bodies = get_overlapping_bodies()
	#for body in overlapping_bodies:
		#if body is Player:
			#_on_body_entered(body)

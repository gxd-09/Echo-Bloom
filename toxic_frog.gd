extends CharacterBody2D
class_name FrogEnemy

const speed = 20
var is_frog_chase: bool = true

var health = 80
var health_max = 80
var health_min = 0
var dead: bool = false
var is_roaming: bool = true
var taking_damage: bool = false
var damage_to_deal = 25
var is_dealing_damage: bool = false

var dir: Vector2
const gravity = 900
var knockback_force = -20
#
#
var player: CharacterBody2D

var player_in_area = false

func _ready():
	player = MyGlobal.playerBody

func _process(delta):
	MyGlobal.frogDamageAmount = damage_to_deal
	MyGlobal.frogDamageZone = $FrogDealDamageArea
	player = MyGlobal.playerBody
	
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0
	move(delta)
	handle_animation()
	move_and_slide()
	
	if MyGlobal.playerAlive:
		is_frog_chase = true
	elif !MyGlobal.playerAlive:
		is_frog_chase = false
	#
#
func move(delta):
	player = MyGlobal.playerBody
	if !dead:
		is_roaming = true
		if !is_frog_chase:
			velocity += dir * speed * delta
		elif is_frog_chase and MyGlobal.playerAlive:
			var dir_to_player = position.direction_to(player.position) * speed
			velocity.x = dir_to_player.x
			dir.x = abs(velocity.x) / velocity.x
		#elif taking_damage:
			#var knockback_dir = position.direction_to(player.position) * knockback_force
			#velocity.x = knockback_dir.x
	elif dead:
		velocity.x = 0
	move_and_slide()
	
func _on_frog_deal_damage_area_area_entered(area: Area2D) -> void:
	is_dealing_damage = true
	handle_animation()
	if area.get_parent() is Player:
		area.get_parent().take_damage(damage_to_deal)

func _on_frog_deal_damage_area_area_exited(_area: Area2D) -> void:
	is_dealing_damage = false
	handle_animation()
		


func handle_animation():
	var anim_sprite = $AnimatedSprite2D
	
	#walking
	if !dead and !taking_damage and !is_dealing_damage:
		anim_sprite.play("walk")
		if dir.x == -1:
			anim_sprite.flip_h = true
		elif dir.x == 1:
			anim_sprite.flip_h = false
	#taking damage
	elif !dead and taking_damage and !is_dealing_damage:
		anim_sprite.play("hurt")
		await get_tree().create_timer(0.8).timeout
		taking_damage = false
	#dead
	elif dead and is_roaming:
		is_roaming = false
		anim_sprite.play("death")
		await get_tree().create_timer(1.0).timeout
		handle_death()
	#frog deals damage
	elif !dead and is_dealing_damage:
		anim_sprite.play("deal_damage")
		
		
		
func handle_death():
	self.queue_free()
	#points += 1?		
			#
#
func _on_timer_timeout() -> void:
	$DirectionTimer.wait_time = choose([1.5,2.0,2.5])
	if !is_frog_chase:
		dir = choose([Vector2.RIGHT, Vector2.LEFT])
		velocity.x = 0
	
func choose(array):
	array.shuffle()
	return array.front()
	#
#
#
##func _on_frog_hitbox_area_entered(area: Area2D) -> void:
	 ###!
	##if area == MyGlobal.playerDamageZone:
		##var damage = MyGlobal.playerDamageAmount #!
		##take_damage(damage)
		##
##func take_damage(damage):
	##health -= damage
	##taking_damage = true
	##if health <= health_min:
		##health = health_min
		##dead = true
	##print(str(self), "current health is ",health)
	###
	##
##
	##
	##
##
##
##func _on_frog_deal_damage_area_area_entered(area: Area2D) -> void:
	##if area == MyGlobal.playerHitbox:
		##is_dealing_damage = true
		##await get_tree().create_timer(1.0).timeout
		##is_dealing_damage = false

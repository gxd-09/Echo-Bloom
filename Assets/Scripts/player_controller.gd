extends CharacterBody2D
class_name Player
@export var animation_player: AnimationPlayer

@onready var normal_speed = 5.0
@onready var speed = 0
@export var jump_power = 10.0
@export var dashspeed = 20
@export var dashlength = .1
@onready var dash = $"Dash"

@onready var speed_multiplier = 20.0
var jump_multiplier = -30.0
var jump_count
var direction = 0

var attack_type: String
var current_attack: bool
@onready var dash_cloud = $dash_cloud

var health = 100
var health_max = 100
var health_min = 0
var can_take_damage: bool
var dead: bool
@onready var deal_damage_zone = $DealDamageZone



#const SPEED = 50.0
#const JUMP_VELOCITY = -400.0

func _ready():
	
	MyGlobal.playerBody = self
	dash_cloud.visible = false
	dead = false
	can_take_damage = true

func _physics_process(delta: float) -> void:
	MyGlobal.playerHitbox = $PlayerHitbox
	if !dead:
		if Input.is_action_just_pressed("dash"):
			dash_cloud.visible = true
			dash_cloud.play("dash")
			dash.start_dash(dashlength)
			await get_tree().create_timer(0.75).timeout
			dash_cloud.visible = false
		
		if dash.is_dashing():
			speed = dashspeed
		else:
			speed = normal_speed
		
		
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
		else:
			jump_count = 0

		# Handle jump.
		if Input.is_action_just_pressed("jump") and jump_count < 2:
			velocity.y = jump_power * jump_multiplier
			jump_count += 1
			#$coin_audio.play()

		# Get the input direction and handle the movement/deceleration.
		direction = Input.get_axis("walk_left", "walk_right")
		if direction:
			velocity.x = direction * speed * speed_multiplier
		else:
			velocity.x = move_toward(velocity.x, 0.0, normal_speed * speed_multiplier)
		
		if !current_attack:
			if Input.is_action_just_pressed("left_mouse") and is_on_floor():
				current_attack = true
				animation_player.play("attack")
		#check_hitbox()
		
		
	move_and_slide()
	
	


#Player take damage

#func check_hitbox():
	#var hitbox_areas = $PlayerHitbox.get_overlapping_areas()
	#var damage: int
	#if hitbox_areas:
		#var hitbox = hitbox_areas.front()
		#if hitbox.get_parent() is FrogEnemy:
			#damage = MyGlobal.frogDamageAmount
	#if can_take_damage:
		#take_damage(damage)
			
#func take_damage(damage):
	#if damage != 0:
		#print("test: ",damage)
		#if health > 0:
			#health -= damage
			#print("player health: ", health)
			#if health <0:
				#health = 0
				#dead = true
				#MyGlobal.playerAlive = false
				#self.queue_free()
			#take_damage_cooldown(1.0)
#
#func take_damage_cooldown(wait_time):
	#can_take_damage = false
	#await get_tree().create_timer(wait_time).timeout


func take_damage(damage):
	health -= damage
	print("Current player health: ")
	
	if health <=0:
		die()
		
func die():
	print("Game over")
		

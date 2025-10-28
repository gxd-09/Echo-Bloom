extends CharacterBody2D
class_name Player

@export var speed = 5.0
@export var jump_power = 10.0

var speed_multiplier = 20.0
var jump_multiplier = -30.0
var direction = 0

var attack_type: String

#const SPEED = 50.0
#const JUMP_VELOCITY = -400.0

func _ready():
	MyGlobal.playerBody = self

func _physics_process(delta: float) -> void:
	MyGlobal.playerHitbox = $PlayerHitbox
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier
		#$coin_audio.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("walk_left", "walk_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

	move_and_slide()
	
	


#Player take damage

#func check_hitbox():
	#var hitbox_areas = $PlayerHitbox.get_overlapping_areas()
	#var damage: int
	#if hitbox_areas:
		#var hitbox = hitbox_areas.front()
		#if hitbox.get_parent() is FrogEnemy:
			#damage = MyGlobal.frogDamageAmount

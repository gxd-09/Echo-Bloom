extends CharacterBody2D
class_name Player

@export var normal_speed = 5.0
var speed = 0
@export var jump_power = 10.0
@export var dashspeed = 20
@export var dashlength = .1
@onready var dash = $"Dash"

var speed_multiplier = 20.0
var jump_multiplier = -30.0
var jump_count
var direction = 0

var attack_type: String
var current_attack: bool
@onready var dash_cloud = $dash_cloud


#const SPEED = 50.0
#const JUMP_VELOCITY = -400.0

func _ready():
	MyGlobal.playerWeaponEquip = false
	MyGlobal.playerBody = self
	dash_cloud.visible = false

func _physics_process(delta: float) -> void:
	MyGlobal.playerHitbox = $PlayerHitbox
	
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
		velocity.x = move_toward(velocity.x, 0, normal_speed * speed_multiplier)
		

	move_and_slide()
	
	


#Player take damage

func check_hitbox():
	var hitbox_areas = $PlayerHitbox.get_overlapping_areas()
	var damage: int
	if hitbox_areas:
		var hitbox = hitbox_areas.front()
		if hitbox.get_parent() is FrogEnemy:
			damage = MyGlobal.frogDamageAmount

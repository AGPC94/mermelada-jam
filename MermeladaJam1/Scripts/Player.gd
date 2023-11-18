extends CharacterBody2D


@export_category("Jump")
@export var jump_speed_full = 300
@export var jump_speed_short = 100

@export_category("Walk")
@export var move_speed_max = 100
@export var move_acceleration = 600
@export var move_friction = 800

@export_category("Hurt")
@export var knockback_speed_x = 100
@export var knockback_speed_y = 100
@export var knockback_time : float = 1
@export var invincible_time = 100


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 2
var input_h
var is_hurt
var is_moving = true

@onready var coyote_timer = $coyote_timer
@onready var jump_buffer_timer = $jump_buffer_timer
@onready var ouch = $Ouch

func _ready():
	ouch.visible = false

func _physics_process(delta) -> void:
	apply_gravity(delta)
	
	if is_moving:
		inputs()
		
		is_coyote_time()
		is_jump_buffer()
		handle_jump()
		horizontal_move(delta)
	
	move_and_slide()

func inputs():
	input_h = Input.get_axis("left", "right")
	
func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
func is_coyote_time():
	if is_on_floor() and velocity.y <= 0:
		coyote_timer.start()
	return coyote_timer.time_left > 0.0
	
func is_jump_buffer():
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer.start()
	return jump_buffer_timer.time_left > 0.0

func full_jump():
	if is_jump_buffer():
		velocity.y = -jump_speed_full
		jump_buffer_timer.stop()
		coyote_timer.stop

func short_jump():
	if Input.is_action_just_released("jump") and velocity.y < -jump_speed_short:
		velocity.y = -jump_speed_short
		
func handle_jump():
	if is_coyote_time():
		full_jump()
	short_jump()
	
func horizontal_move(delta):
	if input_h:
		velocity.x = move_toward(velocity.x, move_speed_max * input_h, move_acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, move_friction * delta)

func hurt(object_position : Vector2):
	if is_hurt:
		return
	
	var knockback_direction : Vector2
	knockback_direction.x = knockback_speed_x
	knockback_direction.y = -knockback_speed_y
		
	if global_position.x < object_position.x:
		knockback_direction.x = -abs(knockback_direction.x)
	else:
		knockback_direction.x = abs(knockback_direction.x)
		
	velocity = knockback_direction
	
	
	is_hurt = true
	is_moving = false
	ouch.visible = true
	
	await get_tree().create_timer(knockback_time).timeout
	
	is_moving = true
	
	await get_tree().create_timer(invincible_time).timeout
	
	is_hurt = false
	ouch.visible = false

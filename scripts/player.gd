extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite = $AnimatedSprite2D
var facing_direction = false
var is_rolling : bool = false
var can_roll : bool = true
@onready var dash_timer = $DashTimer
@onready var dash_cooldown_timer = $DashCooldownTimer
var panda_spirit_mod : bool = false
var is_animation_locked : bool = false

func play_special_animation(animation : String) :
	is_animation_locked = true
	animated_sprite.play(animation)
	await animated_sprite.animation_finished
	is_animation_locked = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("dash_roll") and can_roll:
		dash_timer.start()
		dash_cooldown_timer.start()
		is_rolling = true
		can_roll = false
		play_special_animation("dash_roll")

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction > 0:
		facing_direction = false
	elif direction < 0:
		facing_direction = true
	
	if !is_animation_locked:
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")
		
	if is_rolling:
		velocity.x = (-1 if facing_direction else 1) * SPEED*2
		
	animated_sprite.flip_h = facing_direction

	move_and_slide()


func _on_dash_timer_timeout() -> void:
	is_rolling = false


func _on_dash_cooldown_timer_timeout() -> void:
	can_roll = true

extends KinematicBody2D

const SPEED = 100*1.5
const GRAVITY = 10*1.5
const JUMP_POWER = -100*3.5
const FLOOR = Vector2(0,-1)

var velocity = Vector2()
var jump_count = 0

func _physics_process(_delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false
		if velocity.y == 0:
			$AnimatedSprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
		if velocity.y == 0:
			$AnimatedSprite.play("jump")
	else:
		velocity.x = 0
		if is_on_floor():
			$AnimatedSprite.play("idle")
		
	if is_on_floor():
		jump_count = 0
	elif velocity.y > 0:
		$AnimatedSprite.play("fall")
	else:
		$AnimatedSprite.play("jump")
		
	if Input.is_action_just_pressed("ui_up"):
		if jump_count < 2:
			velocity.y = JUMP_POWER
			jump_count += 1
	
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, FLOOR)

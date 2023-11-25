extends CharacterBody2D
class_name Player

@onready var _spr = $AnimatedSprite2D
@onready var _jumpSound = $JumpSound

@export var _gravity = 400

var _jumpForce = 200;
var _dir = 0
var _defaultSpeed = 125
var _speed = 125
var _active = true
var _stunned : bool = false

func _physics_process(delta):
	if !is_on_floor() && velocity.y < 500:
		velocity.y += _gravity * delta
	if (velocity.y > 500):
		velocity.y = 500
	if _active:
		if Input.is_action_just_pressed("jump") && is_on_floor():
			_jumpSound.play()
			jump(_jumpForce)
		_dir = Input.get_axis("left", "right")
	velocity.x = _dir * _speed
	updateAnimations()
	move_and_slide()

func jump(force):
	velocity.y = -force
	
func IsActive():
	return _active
	
func SetSpeed(speed):
	_speed = speed

func IsStunned():
	return _stunned
	
func ResetSpeed():
	_speed = _defaultSpeed

func updateAnimations():
	if _dir != 0:
		_spr.flip_h = (_dir == -1)
	if is_on_floor():
		if _dir == 0:
			_spr.play("idle")
		else:
			_spr.play("run")
	else:
			_spr.play("fall")

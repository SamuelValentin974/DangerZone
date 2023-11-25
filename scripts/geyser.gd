extends Node2D

@onready var _animator = $AnimationPlayer

var _timer
var _timeLeft
var _timeSurging

func _ready():
	Timer.new()

func _on_area_2d_body_entered(body):
	if body is Player:
		body.jump(400)

func elevate():
	_animator.play("elevate")
	await get_tree().create_timer(2).timeout
	descend()

func descend():
	_animator.play("descend")

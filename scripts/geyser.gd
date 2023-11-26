extends Node2D

@onready var _animator = $AnimationPlayer
@onready var _waterFallSound = $WaterFall
@onready var _waterAscSound = $WaterAscend

var _timer
var _timeLeft = 0
var _timeSurging = 0
var _force = 400
var _ascending : bool = false
var rng = RandomNumberGenerator.new()

func _ready():
	_timer = Timer.new()
	_timer.name = "TimerGeyser"
	_timer.wait_time  = 1
	_timer.timeout.connect(on_geyser_timer_timeout)
	_timeSurging = rng.randi_range(8, 15)
	_timeLeft = _timeSurging
	add_child(_timer)
	_timer.start()
	_ascending = false

func on_geyser_timer_timeout():
	_timeLeft -= 1
	if (_timeLeft < 0):
		elevate()
		_timeSurging = rng.randi_range(5, 15)
		_timeLeft = _timeSurging

func _on_area_2d_body_entered(body):
	if body is Player && _ascending:
		body.jump(_force)

func elevate():
	_force = 400
	_waterAscSound.play(2.0)
	_animator.play("elevate")
	_ascending = true
	await get_tree().create_timer(2).timeout
	descend()

func descend():
	_waterFallSound.play()
	_force = 200
	_animator.play("descend")
	await get_tree().create_timer(1).timeout
	_ascending = false

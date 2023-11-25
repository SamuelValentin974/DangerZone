extends Area2D
class_name GasBtn

@export var _timeBtn = 5

@onready var _timeLabel = $TimeLabel

var _timeLeft = 0
var _timer
var _actived : bool = true
var _playerNear = false

func _process(delta):
	if _playerNear:
		if Input.is_action_just_pressed("action"):
			ResetTimer()

func _ready():
	_timeLeft = _timeBtn
	_timer = Timer.new()
	_timer.name = "TimerBtn"
	_timer.wait_time  = 1
	_timer.timeout.connect(on_gas_btn_timer_timeout)
	add_child(_timer)
	_timer.start()
	SetTimeLabel(_timeLeft)

func _on_body_entered(body):
	if body is Player:
		_playerNear = true

func ResetTimer():
	_timeLeft = _timeBtn
	SetTimeLabel(_timeLeft)
	if !_actived :
		_actived = true

func SetTimeLabel(value):
	_timeLabel.text = "Time : " + str(value)

func on_gas_btn_timer_timeout():
	if _actived:
		_timeLeft -= 1
		SetTimeLabel(_timeLeft)
		if _timeLeft < 0:
			_actived = false
			SetTimeLabel(0)

func isActive():
	return _actived

func _on_body_exited(body):
	if body is Player:
		_playerNear = false

extends Area2D
class_name GasBtn

@export var _timeBtn = 0

@onready var _timeLabel = $TimeLabel
@onready var _clickSound = $ClickSound

var _timeLeft = 0
var _timer
var _timerAble
var _actived : bool = true
var _playerNear = false
var _able : bool = true
var _cdAble = 10
var _cdGas = 0
var rng = RandomNumberGenerator.new()

func _process(delta):
	if _playerNear:
		if Input.is_action_just_pressed("action") && _able:
			ResetTimer()
			_clickSound.play( )
			_able = false

func _ready():
	_timeBtn = rng.randi_range(12, 20)
	_timeLeft = _timeBtn
	_timer = Timer.new()
	_timer.name = "TimerBtn"
	_timer.wait_time  = 1
	_timer.timeout.connect(on_gas_btn_timer_timeout)
	_timerAble = Timer.new()
	_timerAble.name = "Timer cd"
	_timerAble.wait_time = 1
	_timerAble.timeout.connect(on_gas_cd_timer_timeout)
	add_child(_timerAble)
	add_child(_timer)
	_timer.start()
	_cdGas = _cdAble
	SetTimeLabel(_timeLeft)

func _on_body_entered(body):
	if body is Player:
		_playerNear = true

func ResetTimer():
	_timeBtn = rng.randi_range(8, 15)	
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

func on_gas_cd_timer_timeout():
	if !_able :
		_cdGas -= 1
		if (_cdGas < 0):
			_able = true
			_cdGas = _cdAble

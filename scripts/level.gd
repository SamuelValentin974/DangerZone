extends Node2D

var _pipes
var _countPipes = 0
var _activePipes = 0
var _timer
var _score = 0

@onready var _hud = $UILayer/HUD
@onready var _spawnPos = $SpawnPos
@onready var _player = $Player
@onready var _ui = $UILayer

func _ready():
	ResetPlayer()
	_pipes = get_tree().get_nodes_in_group("pipes")
	for pipe in _pipes:
		if pipe is GasBtn:
			if pipe.isActive() :
				_activePipes += 1
			_countPipes += 1
	_hud.SetActiveLabel(_activePipes, _countPipes)
	_hud.SetScore(_score)
	_timer = Timer.new()
	_timer.name = "Score Timer"
	_timer.wait_time = 1
	_timer.timeout.connect(on_score_timer_timeout)
	add_child(_timer)
	_timer.start()

func CheckActives():
	_activePipes = 0
	for pipe in _pipes:
		if pipe is GasBtn:
			if pipe.isActive() :
				_activePipes += 1
	_hud.SetActiveLabel(_activePipes, _countPipes)

func _process(delta):
	CheckInputs()
	CheckActives()
	if (_activePipes == 0) :
		_ui.setLoseScreen(_score, 0, true)
		_player._active = false
		_player._dir = 0

func ResetPlayer():
	_player.velocity = Vector2.ZERO
	_player.global_position = _spawnPos.global_position

func CheckInputs():
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func on_score_timer_timeout():
	if _player is Player:
		if _player.IsActive():
			_score += 10
			_hud.SetScore(_score)
	

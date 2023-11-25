extends Node2D

var _pipes
var _countPipes = 0
var _activePipes = 0

@onready var _hud = $UILayer/HUD

func _ready():
	_pipes = get_tree().get_nodes_in_group("pipes")
	for pipe in _pipes:
		if pipe is GasBtn:
			if pipe.isActive() :
				_activePipes += 1
			_countPipes += 1
	_hud.SetActiveLabel(_activePipes, _countPipes)

func CheckActives():
	var nb = 0
	for pipe in _pipes:
		if pipe is GasBtn:
			if pipe.isActive() :
				nb += 1
	_hud.SetActiveLabel(nb, _countPipes)	

func _process(delta):
	CheckInputs()
	CheckActives()

func CheckInputs():
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

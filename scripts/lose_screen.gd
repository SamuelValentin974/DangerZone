extends Control

@onready var _scoreLabel = $ScoreLabel

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _on_quit_btn_pressed():
	get_tree().quit()

func _on_retry_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/level.tscn")
	
func SetScoreLabel(score):
	_scoreLabel.text = "Score : " + str(score)

extends Control

@onready var _labelActives = $ActivesLabel
@onready var _scoreLabel = $ScoreLabel

func SetActiveLabel(active, total):
	_labelActives.text = "Active pipes : " + str(active) + "/" + str(total)

func SetScore(score):
	_scoreLabel.text = "SCORE : " + str(score)

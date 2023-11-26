extends CanvasLayer

@onready var _loseScreen = $LoseScreen

func setLoseScreen(score, mins, flag : bool):
	_loseScreen.visible = flag
	_loseScreen.SetScoreLabel(score)

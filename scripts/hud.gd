extends Control

@onready var _labelActives = $ActivesLabel

func SetActiveLabel(active, total):
	_labelActives.text = "Pipes active :" + str(active) + "/" + str(total)

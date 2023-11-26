extends Control

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _on_play_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/MGame.tscn")

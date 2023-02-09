extends Control

func _on_StartBTN_pressed():
	Gamestate.load_level(1, Vector2(0, 20))

func _on_OptionsBTN_pressed():
	get_tree().change_scene()

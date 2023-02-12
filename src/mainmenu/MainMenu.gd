extends Control

func _ready() -> void:
	randomize()

func _on_StartBTN_pressed() -> void:
	SoundManager.play_menu_click()
	Gamestate.load_level(0, Vector2(0, 20))
	SoundManager.main_menu_bg.stop()

func _on_OptionsBTN_pressed():
	SoundManager.play_menu_click()
	Gamestate.load_settings_menu()

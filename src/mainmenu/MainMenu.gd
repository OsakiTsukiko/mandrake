extends Control

onready var start_btn = $StartBTN

func _ready() -> void:
	randomize()
	if (PlayerManager.last_level != -1):
		start_btn.text = "Continue"
	else:
		start_btn.text = "Start"

func _on_StartBTN_pressed() -> void:
	if (PlayerManager.last_level != -1):
		if (PlayerManager.last_level == 0):
			Gamestate.load_level(0, Vector2(18, 21))
		if (PlayerManager.last_level == 1):
			Gamestate.load_level(1, Vector2(32, 29))
	else:
		Gamestate.load_level(0, Vector2(0, 20))

func _on_OptionsBTN_pressed():
	Gamestate.load_settings_menu()

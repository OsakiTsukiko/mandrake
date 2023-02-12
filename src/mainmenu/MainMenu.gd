extends Control

onready var connect_btn = $ContinueBTN

func _ready() -> void:
	randomize()
	if (PlayerManager.last_level != -1):
		connect_btn.disabled = false
	else:
		connect_btn.disabled = true

func _on_StartBTN_pressed() -> void:
	PlayerManager.death_reset()
	Gamestate.state.has_book = false
	Gamestate.state.first_time_dwarf = true
	Gamestate.load_level(0, Vector2(0, 20))

func _on_OptionsBTN_pressed():
	Gamestate.load_settings_menu()

func _on_ContinueBTN_pressed():
	if (PlayerManager.last_level == 0):
		Gamestate.load_level(0, Vector2(18, 21))
	if (PlayerManager.last_level == 1):
		Gamestate.load_level(1, Vector2(32, 29))

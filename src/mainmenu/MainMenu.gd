extends Control

func _ready() -> void:
	randomize()

func _on_StartBTN_pressed() -> void:
	Gamestate.load_level(0, Vector2(0, 20))

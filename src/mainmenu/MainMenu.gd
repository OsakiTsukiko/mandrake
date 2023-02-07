extends Control

onready var transition_screen = $TransitionScreen

func _ready():
	transition_screen.connect("animation_close_done", self, "_animation_close_done")
	transition_screen.play_open_animation()

func _on_StartBTN_pressed():
	transition_screen.play_close_animation()

func _animation_close_done():
	Gamestate.load_level(1, Vector2(0, 20))

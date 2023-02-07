extends Control

onready var transition = $CircleTransition

func _on_StartBTN_pressed():
	transition.play_close_animation()

func _ready():
	transition.connect("animation_close_done", self, "_animation_close_done")
	transition.play_open_animation()
	pass


func _animation_close_done():
	Gamestate.load_level(1, Vector2(0, 20))

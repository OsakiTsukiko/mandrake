extends ColorRect

onready var animation_player = $AnimationPlayer
signal animation_close_done
signal animation_open_done

func _ready() -> void:
	update_screen_dimensions()
	pass

func update_screen_dimensions() -> void:
	var screen_dimensions = get_viewport_rect()
	material.set_shader_param("screen_width", screen_dimensions.size.x)
	material.set_shader_param("screen_height", screen_dimensions.size.y)
	pass

func play_open_animation() -> void:
	visible = true
	animation_player.play("transition_open_circle")
	pass

func play_close_animation() -> void:
	visible = true
	animation_player.play("transition_close_circle")
	pass

func _on_animation_finished(animation_name) -> void:
	if animation_name == "transition_open_circle":
		material.set_shader_param("circle_size", 0.0)
		visible = false
		emit_signal("animation_open_done")
	
	if animation_name == "transition_close_circle":
		material.set_shader_param("circle_size", 1.05)
		visible = true
		emit_signal("animation_close_done")
	
	pass

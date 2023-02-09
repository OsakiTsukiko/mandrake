extends ColorRect

onready var animation_player = $AnimationPlayer

signal animation_close_done
signal animation_open_done

var params_oa: Array
var params_ca: Array

func play_open_animation(pos_ratio: Vector2, params: Array = []) -> void:
	params_oa = params
	visible = true
	material.set_shader_param("circle_centre_x", pos_ratio.x)
	material.set_shader_param("circle_centre_y", pos_ratio.y)
	animation_player.play("transition_open_circle")

func play_close_animation(pos_ratio: Vector2, params: Array = []) -> void:
	params_ca = params
	visible = true
	material.set_shader_param("circle_centre_x", pos_ratio.x)
	material.set_shader_param("circle_centre_y", pos_ratio.y)
	animation_player.play("transition_close_circle")

func _on_animation_finished(animation_name) -> void:
	if (animation_name == "transition_open_circle"):
		material.set_shader_param("circle_size", 0.0)
		visible = false
		emit_signal("animation_open_done", params_oa)
	
	if (animation_name == "transition_close_circle"):
		material.set_shader_param("circle_size", 1.05)
		visible = true
		emit_signal("animation_close_done", params_ca)

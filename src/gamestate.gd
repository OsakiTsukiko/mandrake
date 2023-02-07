extends Node

var levels = [
	load("res://src/level_01/Level_01.tscn"),
	load("res://src/level_02/Level_02.tscn")
]

var state: Dictionary = {
	"first_time_dwarf": true
}

signal spawn_coords

func load_level(id: int, spawn_coords: Vector2 = Vector2.ZERO) -> void:
	get_tree().change_scene_to(levels[id - 1])
	if (spawn_coords != Vector2.ZERO):
		call_deferred("emit_signal", "spawn_coords", spawn_coords)

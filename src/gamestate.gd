extends Node

var combat_scene: Resource = load("res://src/combat/Combat.tscn")

var levels: Array = [
	load("res://src/level_01/Level_01.tscn"),
	load("res://src/level_02/Level_02.tscn")
]

var state: Dictionary = {
	"first_time_dwarf": true,
	"has_book": false
}

signal spawn_coords
signal init_arena
signal close_book_signal

var last_level: int
var last_coords: Vector2

func load_level(id: int, spawn_coords: Vector2 = Vector2.ZERO) -> void:
	get_tree().change_scene_to(levels[id])
	if (spawn_coords != Vector2.ZERO):
		call_deferred("emit_signal", "spawn_coords", spawn_coords)

func load_arena(
	level_id: int, 
	last_coords: Vector2,
	mob_type: int, 
	mob_id: int
	) -> void:
	self.last_level = level_id
	self.last_coords = last_coords
	get_tree().change_scene_to(combat_scene)
	call_deferred("emit_signal", "init_arena", level_id, mob_type, mob_id)

func close_book() -> void:
	call_deferred("emit_signal", "close_book_signal")

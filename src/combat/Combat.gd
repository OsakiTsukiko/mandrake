extends Node2D

onready var background = $Background
onready var mandrake = $Mandrake
onready var mob_node = $Mob

var arena: Utils.Arena
var mob: Utils.Mob
var mob_type: int

func _ready() -> void:
	Gamestate.connect("init_arena", self, "_init_arena")

func _init_arena(level_id: int, mob_type: int, mob_id: int) -> void:
	arena = AssetManager.arenas[level_id]
	background.texture = arena.background
	self.mob_type = mob_type
	if (mob_type == 0):
		mob = arena.mobs[mob_id].duplicate()
	else:
		mob = arena.guardian.duplicate()
	mob_node.scale = mob.scale
	mob_node.offset = Vector2(
		0,
		-mob.texture.get_height() / 2
	)
	mob_node.texture = mob.texture
	mob_node.scale = mob.scale
	print(mob_node.offset)

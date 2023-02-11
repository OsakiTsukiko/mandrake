extends Node2D

onready var player = $Player

onready var light_node = $Lights
onready var screen_color_overlay = $CanvasModulate

onready var transition_screen = $CanvasLayer/TransitionScreen

onready var collision_tilemap = $CollisionTileMap
onready var action_tilemap = $ActionTileMap
onready var lighting_tilemap = $LightingTileMap

onready var book = $BOOK_CONT/SkillMenu

var level_id = 1
var arena: Utils.Arena

func _ready() -> void:
	Gamestate.connect("spawn_coords", self, "_spawn_coords")
	Gamestate.connect("close_book_signal", self, "_close_book_signal")
	transition_screen.connect("animation_close_done", self, "_animation_close_done")
	transition_screen.connect("animation_open_done", self, "_animation_open_done")
	transition_screen.play_open_animation(player.get_on_screen_ratio())
	player.not_occupied = false
	arena = AssetManager.arenas[level_id]
	screen_color_overlay.show()
	create_lights()

func _spawn_coords(coords: Vector2):
	player.teleport(coords)

func _physics_process(delta) -> void:
	player.hide_action_key_popup()
	
	if (player.not_occupied && action_tilemap.get_cellv(player.coord) != -1):
		var action: int = action_tilemap.get_cellv(player.coord)
		if (action == Utils.ACTIONS_ENUM.REGRESS_TO_PREVIOUS_LEVEL):
			player.show_action_key_popup()
			if (Input.is_action_just_pressed("action_key")):
				player.not_occupied = false
				transition_screen.play_close_animation(player.get_on_screen_ratio(), ["REGRESS_TO_PREVIOUS_LEVEL", 0, Vector2(43, 22)])
	
	if (player.not_occupied && Input.is_action_just_pressed("open_book") && Gamestate.state.has_book):
		player.not_occupied = false
		book.open()
		book.visible = true
	
func _player_moved(pos: Vector2) -> void:
	var action: int = action_tilemap.get_cellv(Utils.pos_to_coords(pos))
	if (action == 6):
		var rand = randi()
		if (rand % 3 == 0):
			var mob_rand = randi()
			var mob_id = mob_rand % arena.mobs.size()
			Gamestate.load_arena(
				level_id,
				player.coord,
				0,
				mob_id
			)

func create_lights() -> void:
	var lightingtilemap_rect = lighting_tilemap.get_used_rect()
	
	for i in range(lightingtilemap_rect.size.x):
		for j in range(lightingtilemap_rect.size.y):
			var cell_coord = Vector2(i + lightingtilemap_rect.position.x, j + lightingtilemap_rect.position.y)
			if (lighting_tilemap.get_cell(cell_coord.x, cell_coord.y) != -1):
				var light = Light2D.new() 
				light.texture = AssetManager.light_texture
				light.mode = Light2D.MODE_MIX
				light.position = cell_coord * 16 + Vector2(8, 8)
				light.texture_scale = 5
				light.shadow_enabled = true
				light_node.add_child(light)

func _animation_open_done(params: Array) -> void:
	player.not_occupied = true

func _animation_close_done(params: Array) -> void:
	if (params[0] == "REGRESS_TO_PREVIOUS_LEVEL"):
		Gamestate.load_level(params[1], params[2])

func _close_book_signal() -> void:
	player.not_occupied = true

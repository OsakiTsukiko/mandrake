extends Node2D

onready var player = $Player

onready var transition_screen = $CanvasLayer/TransitionScreen

onready var collision_tilemap = $CollisionTileMap
onready var action_tilemap = $ActionTileMap

func _ready() -> void:
	Gamestate.connect("spawn_coords", self, "_spawn_coords")
  transition_screen.connect("animation_close_done", self, "_animation_close_done")
	transition_screen.play_open_animation()

func _spawn_coords(coords: Vector2):
	player.teleport(coords)

func _physics_process(delta) -> void:
	player.hide_action_key_popup()
	
	if (player.not_occupied && action_tilemap.get_cellv(player.coord) != -1):
		var action: int = action_tilemap.get_cellv(player.coord)
		if (action == Utils.ACTIONS_ENUM.SPEAK_WITH_DWARF):
			player.show_action_key_popup()
			if (Input.is_action_just_pressed("action_key")):
				player.not_occupied = false
				var dialogue = Dialogic.start("starting_dialogue_01")
				Dialogic.set_variable("first_time_dwarf", String(Gamestate.state.first_time_dwarf))
				if (Gamestate.state.first_time_dwarf):
					Gamestate.state.first_time_dwarf = false
				add_child(dialogue)
				dialogue.connect("timeline_end", self, "_end_dialogue", [dialogue])
		if (action == Utils.ACTIONS_ENUM.PROGRESS_TO_NEXT_LEVEL):
			player.show_action_key_popup()
			if (Input.is_action_just_pressed("action_key")):
				player.not_occupied = false
        transition_screen.play_close_animation()
				# Gamestate.load_level(2, Vector2(7, 15))

func _player_moved(pos: Vector2):
	var action: int = action_tilemap.get_cellv(Utils.pos_to_coords(pos))

func _end_dialogue(timeline_name: String, node: Node):
	node.queue_free()
	if (timeline_name == "starting_dialogue_01"):
		player.not_occupied = true

func _animation_close_done():
	Gamestate.load_level(2, Vector2(7, 15))

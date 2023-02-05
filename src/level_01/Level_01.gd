extends Node2D

"""
This approach might be a bit weird
I dont instance Player for each level,
I build it baked into the level..
This might be a bit bad for large scale
stuff.. in this case is fine + im too lazy
to modify everything to work with that..
So this will have to do for now.
"""

onready var player = $Player
onready var action_key_popup = $Player/ActionKeyPopup

onready var collision_tilemap = $CollisionTileMap
onready var action_tilemap = $ActionTileMap

var cell_size: Vector2 = Vector2(16, 16)

var changed_pos: Vector2 = Vector2.ZERO
var last_input_vector: Vector2 = Vector2.ZERO
var coord: Vector2 = Vector2.ZERO

var not_occupied: bool = true

func _ready() -> void:
	teleport_player_at(Vector2(1, 21))

func teleport_player_at(pos: Vector2) -> void:
	player.global_position = pos * 16
	coord = pos
	changed_pos = pos * 16

func _physics_process(delta) -> void:
	action_key_popup.visible = false
	var input_vector: Vector2 = Vector2(
		int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")),
		int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	)

	if input_vector.x != 0 && last_input_vector.x == 0:
		input_vector.y = 0
	if input_vector.y != 0 && last_input_vector.y == 0:
		input_vector.x = 0
	
	if (
		not_occupied &&
		(player.global_position.x > changed_pos.x - 0.1) && (player.global_position.x < changed_pos.x + 0.1) &&
		(player.global_position.y > changed_pos.y - 0.1) && (player.global_position.y < changed_pos.y + 0.1)
		):
		
		if (collision_tilemap.get_cellv(coord + input_vector) == -1):
			coord += input_vector
			changed_pos = coord * 16
		if (action_tilemap.get_cellv(coord + input_vector) != -1):
			pass
			# action of next position
		last_input_vector = input_vector
	player.global_position = lerp(player.global_position, changed_pos, delta * 20)

	if (not_occupied && action_tilemap.get_cellv(coord) != -1):
		var action: int = action_tilemap.get_cellv(coord)
		if (action == Utils.ACTIONS_ENUM.SPEAK_WITH_DWARF):
			action_key_popup.visible = true
			if (Input.is_action_just_pressed("action_key")):
				not_occupied = false
				var dialogue = Dialogic.start("starting_dialogue_01")
				Dialogic.set_variable("first_time_dwarf", String(Gamestate.state.first_time_dwarf))
				if (Gamestate.state.first_time_dwarf):
					Gamestate.state.first_time_dwarf = false
				add_child(dialogue)
				dialogue.connect("timeline_end", self, "_end_dialogue", [dialogue])

func _end_dialogue(timeline_name: String, node: Node):
	node.queue_free()
	if (timeline_name == "starting_dialogue_01"):
		not_occupied = true
	

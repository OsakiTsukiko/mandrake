extends Node2D

onready var player = $Player
onready var collision_tilemap = $Collision

var cell_size: Vector2 = Vector2(16, 16)

var changed_pos: Vector2 = Vector2.ZERO
var last_input_vector: Vector2 = Vector2.ZERO
var coord: Vector2 = Vector2.ZERO

var is_able_to_move: bool = true

func _ready() -> void:
	coord = Utils.pos_to_coords(player.global_position)
	changed_pos = player.global_position

func _physics_process(delta) -> void:
	var input_vector: Vector2 = Vector2(
		int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")),
		int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	)

	if input_vector.x != 0 && last_input_vector.x == 0:
		input_vector.y = 0
	if input_vector.y != 0 && last_input_vector.y == 0:
		input_vector.x = 0
	
	if (
		is_able_to_move &&
		(player.global_position.x > changed_pos.x - 0.1) && (player.global_position.x < changed_pos.x + 0.1) &&
		(player.global_position.y > changed_pos.y - 0.1) && (player.global_position.y < changed_pos.y + 0.1)
		):
		
		if (collision_tilemap.get_cellv(coord + input_vector) == -1):
			coord += input_vector
			changed_pos = coord * 16
		last_input_vector = input_vector
	player.global_position = lerp(player.global_position, changed_pos, delta * 20)

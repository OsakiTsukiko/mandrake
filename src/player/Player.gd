extends Sprite

onready var action_key_popup = $ActionKeyPopup
onready var camera = $Camera2D

onready var collision_tilemap = get_parent().get_node("CollisionTileMap")

var cell_size: Vector2 = Vector2(16, 16)

var changed_pos: Vector2 = Vector2.ZERO
var last_input_vector: Vector2 = Vector2.ZERO
var coord: Vector2 = Vector2.ZERO

var not_occupied: bool = true

var last_changed_pos: Vector2 = Vector2.ZERO

func teleport(pos: Vector2) -> void:
	global_position = pos * 16
	coord = pos
	changed_pos = pos * 16
	last_changed_pos = changed_pos

func get_on_screen_ratio() -> Vector2:
	var screen_size: Vector2 = get_viewport_rect().size
	var camera_position: Vector2 = camera.position
	var player_position_in_vieport = Vector2.ZERO
	var player_size = get_rect().size
	
	screen_size.x *= camera.zoom.x
	screen_size.y *= camera.zoom.y
	
	player_position_in_vieport.y = screen_size.y / 2 - camera_position.y + player_size.x / 2
	player_position_in_vieport.x = screen_size.x / 2 - camera_position.x + player_size.y / 2
	print(player_position_in_vieport)
	return Vector2(player_position_in_vieport.x / screen_size.x, player_position_in_vieport.y / screen_size.y)

func show_action_key_popup() -> void:
	action_key_popup.visible = true

func hide_action_key_popup() -> void:
	action_key_popup.visible = false

func _physics_process(delta) -> void:
	
	print(get_on_screen_ratio())
	
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
		(global_position.x > changed_pos.x - 0.1) && (global_position.x < changed_pos.x + 0.1) &&
		(global_position.y > changed_pos.y - 0.1) && (global_position.y < changed_pos.y + 0.1)
		):
		
		if (collision_tilemap.get_cellv(coord + input_vector) == -1):
			coord += input_vector
			changed_pos = coord * 16
			
		last_input_vector = input_vector
	
	if (last_changed_pos != changed_pos):
		if (get_parent().has_method("_player_moved")):
			get_parent()._player_moved(changed_pos)
	
	last_changed_pos = changed_pos
	
	global_position = lerp(global_position, changed_pos, delta * 20)

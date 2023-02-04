extends Node
class_name Utils

enum ACTIONS_ENUM {
	SPEAK_WITH_DWARF = 0
}

static func pos_to_coords(pos: Vector2) -> Vector2:
	return Vector2(floor(pos.x / 16), floor(pos.y / 16))

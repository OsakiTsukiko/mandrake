extends Node
class_name Utils

enum ACTIONS_ENUM {
	SPEAK_WITH_DWARF = 0,
	PROGRESS_TO_NEXT_LEVEL = 1,
	REGRESS_TO_PREVIOUS_LEVEL = 2,
}

static func pos_to_coords(pos: Vector2) -> Vector2:
	return Vector2(floor(pos.x / 16), floor(pos.y / 16))

class Arena: 
	var name: String
	var background: Resource
	var mobs: Array
	var guardian: Mob
	
	func _init(
		name: String, 
		background: Resource,
		mobs: Array,
		guardian: Mob
		):
		self.name = name
		self.background = background
		self.mobs = mobs
		self.guardian = guardian

class Mob:
	var name: String
	var texture: Resource
	var health: int
	var min_dmg: int
	var max_dmg: int
	var size: int
	var scale: Vector2
	
	func _init(
		name: String, 
		texture: Resource, 
		health: int, 
		min_dmg: int,
		max_dmg: int,
		size: int,
		scale: Vector2
		):
		self.name = name
		self.texture = texture
		self.health = health
		self.min_dmg = min_dmg
		self.max_dmg = max_dmg
		self.size = size
		self.scale = scale
	
	func duplicate() -> Mob:
		var copy: Mob = get_script().new(
			name,
			texture.duplicate(),
			health,
			min_dmg,
			max_dmg,
			size,
			scale
		)
		return copy

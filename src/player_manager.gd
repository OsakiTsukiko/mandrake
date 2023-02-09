extends Node

var base_health: int = 100
var added_health: int = 0
var health: int = base_health + added_health

var skills = {
	"defense": [
		Utils.Attack.new(
			"Block",
			0,
			Vector2.ZERO,
			Vector2.ZERO,
			Vector2(3, 15),
			0,
			false
		),
		Utils.Attack.new(
			"Super Block",
			0,
			Vector2.ZERO,
			Vector2.ZERO,
			Vector2(25, 50),
			0,
			false
		)
	],
	"attack": [
		Utils.Attack.new(
			"Scream",
			1,
			Vector2.ZERO,
			Vector2(5, 20),
			Vector2.ZERO,
			2,
			true
		),
		Utils.Attack.new(
			"Super Scream",
			1,
			Vector2.ZERO,
			Vector2(15, 50),
			Vector2.ZERO,
			4,
			false
		),
		Utils.Attack.new(
			"Killer Scream",
			1,
			Vector2.ZERO,
			Vector2(25, 150),
			Vector2.ZERO,
			6,
			false
		)
	]
}

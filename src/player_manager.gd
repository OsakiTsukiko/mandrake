extends Node

var health: int = 100

var hp: Dictionary = {
	"points": 2,
	"cap": 20,
	"multiply": 50
}

var mr: Dictionary = {
	"points": 1,
	"cap": 20
}

var def: Dictionary = {
	"points": 0,
	"cap": 20,
	"multiply": 25
}

var ak: Dictionary = {
	"points": 0,
	"cap": 20
}

var sp: Dictionary = {
	"points": 80
}

var points_

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
			Vector2(25, 100),
			10,
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
			1,
			true
		),
		Utils.Attack.new(
			"Super Scream",
			1,
			Vector2.ZERO,
			Vector2(15, 50),
			Vector2.ZERO,
			10,
			false
		),
		Utils.Attack.new(
			"Killer Scream",
			1,
			Vector2.ZERO,
			Vector2(75, 150),
			Vector2.ZERO,
			30,
			false
		)
	]
}

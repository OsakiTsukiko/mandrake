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
	"points": 0
}

func death_reset() -> void:
	health = 100
	hp.points = 2
	mr.points = 1
	def.points = 0
	ak.points = 0
	sp.points = 0
	load_skills([false, false], [true, false, false])

func load_skills(defense: Array, attack: Array) -> void:
	for i in range(0, skills.defense.size()):
		skills.defense[i].unlocked = defense[i]
	for i in range(0, skills.attack.size()):
		skills.attack[i].unlocked = attack[i]

#func _process(delta):
#	if (health > hp.points * hp.cap):
#		health = hp.points * hp.cap

var skills = {
	"defense": [
		Utils.Attack.new(
			"Block",
			0,
			Vector2.ZERO,
			Vector2.ZERO,
			Vector2(15, 30),
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
			Vector2(15, 25),
			Vector2.ZERO,
			1,
			true
		),
		Utils.Attack.new(
			"Super Scream",
			1,
			Vector2.ZERO,
			Vector2(25, 75),
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

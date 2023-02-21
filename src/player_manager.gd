extends Node

var timer: Node
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

var last_level: int = -1

func _ready() -> void:
	var save = Utils.load_save("mandrake")
	print(save)
	if (save != null):
		if (save.has("points")):
			hp.points = save.points[0]
			mr.points = save.points[1]
			def.points = save.points[2]
			ak.points = save.points[3]
			sp.points = save.points[4]
		if (save.has("health")):
			health = save.health
		if (save.has("defense") && save.has("attack")):
			load_skills(save.defense, save.attack)
		if (save.has("has_book")):
			Gamestate.state.has_book = save.has_book
			Gamestate.state.first_time_dwarf = !save.has_book
		if (save.has("level")):
#			if (save.level == 0):
#				Gamestate.load_level(0, Vector2(18, 21))
#			if (save.level == 1):
#				Gamestate.load_level(1, Vector2(32, 29))
			last_level = save.level
		if (save.has("music_volume")):
			SoundManager.music_volume = save.music_volume
		if (save.has("music_toggle")):
			SoundManager.music_toggle = save.music_toggle
		if (save.has("sfx_volume")):
			SoundManager.sfx_volume = save.sfx_volume
		if (save.has("sfx_toggle")):
			SoundManager.sfx_toggle = save.sfx_toggle
	timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.connect("timeout", self, "_timeout")
	self.add_child(timer)

func _timeout():
	var save = save_game_state()
	Utils.save(save, "mandrake")

func save_game_state():
	var save = {}
	save.points = [hp.points, mr.points, def.points, ak.points, sp.points]
	save.health = health
	save.defense = []
	for def in skills.defense:
		save.defense.push_back(def.unlocked)
	save.attack = []
	for def in skills.attack:
		save.attack.push_back(def.unlocked)
	save.has_book = Gamestate.state.has_book
	save.level = last_level
	save.music_volume = SoundManager.music_volume
	save.music_toggle = SoundManager.music_toggle
	save.sfx_volume = SoundManager.sfx_volume
	save.sfx_toggle = SoundManager.sfx_toggle
	return save

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
			Vector2(75, 150),
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
			Vector2(100, 175),
			Vector2.ZERO,
			30,
			false
		)
	]
}

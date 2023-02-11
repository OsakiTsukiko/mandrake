extends Node

var light_texture: Resource = preload("res://assets/lighting/lighting_texture_layered.png")

var arenas = [
	Utils.Arena.new(
		"FILLER",
		preload("res://assets/combat/arenas/level_02/main.png"),
		[
			Utils.Mob.new(
				"Mushy",
				preload("res://assets/mushy/combat/main_02.png"),
				10000,
				0,
				1,
				0,
				Vector2(3, 3)
			)
		],
		Utils.Mob.new(
			"Mushroom Satan",
			preload("res://assets/mushroom_satan/combat/main_01.png"),
			10000,
			0,
			1,
			1,
			Vector2(2, 2)
		)
	),
	Utils.Arena.new(
		"Fluffy Pink",
		preload("res://assets/combat/arenas/level_02/main.png"),
		[
			Utils.Mob.new(
				"Mushy",
				preload("res://assets/mushy/combat/main_02.png"),
				50,
				10,
				50,
				0,
				Vector2(3, 3)
			)
		],
		Utils.Mob.new(
			"Mushroom Satan",
			preload("res://assets/mushroom_satan/combat/main_01.png"),
			800,
			50,
			250,
			1,
			Vector2(2, 2)
		)
	)
]

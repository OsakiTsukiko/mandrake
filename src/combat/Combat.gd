extends Node2D

onready var background: Node = $Background
onready var mandrake: Node = $Mandrake
onready var mob_node: Node = $Mob

onready var mandrake_p2d: Node = $MandrakeP2D
onready var mob_p2d: Node = $MobP2D

onready var crystal: Node = $Overlay/Heart/Crystal

onready var mandrake_anim_player: Node = $Mandrake/AnimationPlayer
onready var mob_anim_player: Node = $Mob/AnimationPlayer

onready var self_hp: Node = $Overlay/SelfStats/HP
onready var self_mp: Node = $Overlay/SelfStats/MP
onready var self_def: Node = $Overlay/SelfStats/DEF

onready var mob_name: Node = $Overlay/MobStats/Name
onready var mob_hp: Node = $Overlay/MobStats/HP

onready var skill_cont_p: Node = $Overlay/SkillCont
onready var skill_cont_n: Node = $Overlay/SkillCont/MarginContainer/ScrollContainer/VBoxContainer

onready var transition_screen = $CanvasLayer/TransitionScreen

var skill_btn_scene: Resource = load("res://src/combat/SkillBTN.tscn")
var action_particle_scene: Resource = load("res://src/combat/ActionParticle.tscn")

var arena: Utils.Arena
var mob: Utils.Mob
var mob_type: int
var mob_initial_health: int

var health: int
var h_anim: float
var mana: int
var shield: int

var msg_val: int

func _ready() -> void:
	Gamestate.connect("init_arena", self, "_init_arena")
	transition_screen.connect("animation_close_done", self, "_animation_close_done")

func _init_arena(level_id: int, mob_type: int, mob_id: int) -> void:
	arena = AssetManager.arenas[level_id]
	background.texture = arena.background
	self.mob_type = mob_type
	if (mob_type == 0):
		mob = arena.mobs[mob_id].duplicate()
	else:
		mob = arena.guardian.duplicate()
	mob_node.scale = mob.scale
	mob_node.offset = Vector2(
		0,
		-mob.texture.get_height() / 2
	)
	mob_node.texture = mob.texture
	mob_node.scale = mob.scale

	health = PlayerManager.health
	h_anim = health * 100 / (PlayerManager.hp.points * PlayerManager.hp.multiply)
	mana = 0
	shield = 0
	
	mob_initial_health = mob.health
	
	update_stats()
	battle_loop_prefix()

func update_stats() -> void:
	self_hp.text = String(health) + "/" + String(PlayerManager.hp.points * PlayerManager.hp.multiply) + "  HP"
	self_mp.text = String(mana) + "  MP"
	self_def.text = String(shield) + "/" + String(PlayerManager.def.points * PlayerManager.def.multiply) + " DEF"
	mob_name.text = mob.name
	mob_hp.text = String(mob.health) + "/" + String(mob_initial_health) + " HP"

func battle_loop_prefix() -> void:
	mana += PlayerManager.mr.points
	update_stats()
	for i in skill_cont_n.get_children():
		i.queue_free()
	
	for i in range(0, PlayerManager.skills.defense.size()):
		var skill: Utils.Attack = PlayerManager.skills.defense[i]
		if (skill.unlocked != true):
			continue
		var skill_btn: Button = skill_btn_scene.instance()
		skill_btn.text = "[D] " + skill.name + " (" + String(skill.mana_required) + " MP)"
		if (skill.mana_required > mana):
			skill_btn.disabled = true
		skill_btn.connect("pressed", self, "_skill_btn", [0, i])
		skill_cont_n.add_child(skill_btn)
	
	for i in range(0, PlayerManager.skills.attack.size()):
		var skill: Utils.Attack = PlayerManager.skills.attack[i]
		if (skill.unlocked != true):
			continue
		var skill_btn: Button = skill_btn_scene.instance()
		skill_btn.text = "[A] " + skill.name + " (" + String(skill.mana_required) + " MP)"
		if (skill.mana_required > mana):
			skill_btn.disabled = true
		skill_btn.connect("pressed", self, "_skill_btn", [1, i])
		skill_cont_n.add_child(skill_btn)
	
	var skill_btn: Button = skill_btn_scene.instance()
	skill_btn.text = "Do Nothing! (0 MP)"
	skill_btn.connect("pressed", self, "_skill_btn", [2, 0])
	skill_cont_n.add_child(skill_btn)
	
	skill_cont_p.visible = true

func _skill_btn(type: int, id: int) -> void:
	
	skill_cont_p.visible = false
	
	var skill: Utils.Attack
	if (type == 0):
		skill = PlayerManager.skills.defense[id]
	if (type == 1):
		skill = PlayerManager.skills.attack[id]
	if (type == 2):
		battle_loop_suffix()
		return
	
	mana -= skill.mana_required
	
	if (skill.target == 0):
		var c: int = randi() % int(skill.defense.y - skill.defense.x)
		shield += skill.defense.x + c
		if (shield > PlayerManager.def.points * PlayerManager.def.multiply):
			shield = PlayerManager.def.points * PlayerManager.def.multiply
		var action_particle: Node2D = action_particle_scene.instance()
		action_particle.init(0, skill.defense.x + c)
		action_particle.position = mandrake_p2d.position
		add_child(action_particle)
		mandrake_anim_player.play("shield")
		return
	
	if (skill.target == 1):
		var c: int = randi() % int(skill.health.y - skill.health.x)
		mob.health -= skill.health.x + c
		msg_val = skill.health.x + c
		mandrake_anim_player.play("attack")
		return

func battle_loop_suffix() -> void:
	if (mob.health <= 0):
		mob_node.visible = false
		yield(get_tree().create_timer(1), "timeout")
		PlayerManager.health = health
		PlayerManager.sp.points += 1
		transition_screen.play_close_animation(["BACK_TO_LEVEL", Gamestate.last_level, Gamestate.last_coords])
		return
		
	var c: int = randi() % (mob.max_dmg - mob.min_dmg)
	var mob_dmg: int = c + mob.min_dmg
	if (shield != 0):
		shield -= mob_dmg
	else:
		health -= mob_dmg
	if (shield < 0):
		health += shield
		shield = 0
	msg_val = mob_dmg
	mob_anim_player.play("attack")

func _on_mandrake_animation_finished(anim_name: String) -> void:
	if (anim_name == "attack"):
		var action_particle: Node2D = action_particle_scene.instance()
		action_particle.init(1, msg_val)
		action_particle.position = mob_p2d.position
		add_child(action_particle)
		mob_anim_player.play("damage")
	if (anim_name == "shield"):
		update_stats()
		battle_loop_suffix()
	if (anim_name == "damage"):
		if (health <= 0):
			health = 0
			update_stats()
			mandrake.visible = false
			yield(get_tree().create_timer(1), "timeout")
			PlayerManager.death_reset()
			transition_screen.play_close_animation(["BACK_TO_START", 0, Vector2(18, 21)])
			return
		update_stats()
		battle_loop_prefix()

func _on_mob_animation_finished(anim_name: String) -> void:
	if (anim_name == "damage"):
		if (mob.health <= 0): 
			mob.health = 0
		update_stats()
		battle_loop_suffix()
	if (anim_name == "attack"):
		var action_particle: Node2D = action_particle_scene.instance()
		action_particle.init(1, msg_val)
		action_particle.position = mandrake_p2d.position
		add_child(action_particle)
		mandrake_anim_player.play("damage")

func _physics_process(delta) -> void:
	h_anim = lerp(h_anim, health * 100 / (PlayerManager.hp.points * PlayerManager.hp.multiply), delta * 2)
	crystal.material.set_shader_param("perc", h_anim)

func _animation_close_done(params: Array) -> void:
	if (params[0] == "BACK_TO_LEVEL" || params[0] == "BACK_TO_START"):
		Gamestate.load_level(params[1], params[2])

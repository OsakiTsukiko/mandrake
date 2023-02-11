extends Control

onready var skill_cont: Node = $MarginContainer/MarginContainer/HBoxContainer/VBoxContainer/SkillsScroll/Skills

onready var hp_node: Node = $MarginContainer/MarginContainer/HBoxContainer/CategoriesScroll/Categories/SGrid/HP_Value
onready var def_node: Node = $MarginContainer/MarginContainer/HBoxContainer/CategoriesScroll/Categories/SGrid/DEF_Value
onready var ak_node: Node = $MarginContainer/MarginContainer/HBoxContainer/CategoriesScroll/Categories/SGrid/AK_Value
onready var mr_node: Node = $MarginContainer/MarginContainer/HBoxContainer/CategoriesScroll/Categories/SGrid/MR_Value
onready var sp_node: Node = $MarginContainer/MarginContainer/HBoxContainer/CategoriesScroll/Categories/SGrid/SP_Value

var skill_scene: Resource = load("res://src/skill_menu/Skill.tscn")

func _ready() -> void:
	update_stats()
	update_skills()

func update_stats() -> void:
	hp_node.text = String(PlayerManager.hp.points * PlayerManager.hp.multiply) + "/" + String(PlayerManager.hp.cap * PlayerManager.hp.multiply)
	def_node.text = String(PlayerManager.def.points * PlayerManager.def.multiply) + "/" + String(PlayerManager.def.cap * PlayerManager.def.multiply)
	ak_node.text = String(PlayerManager.ak.points) + "/" + String(PlayerManager.ak.cap)
	mr_node.text = String(PlayerManager.mr.points) + "/" + String(PlayerManager.mr.cap)
	sp_node.text = String(PlayerManager.sp.points)

func update_skills() -> void:
	for child in skill_cont.get_children():
		child.queue_free()

	for i in range(0, PlayerManager.skills.defense.size()):
		var skill: Utils.Attack = PlayerManager.skills.defense[i]
		if (skill.unlocked != true):
			continue
		var skill_node: Node = skill_scene.instance()
		var skill_desc: String = ""
		skill_desc += "- target: "
		if (skill.target == 0):
			skill_desc += "self"
		if (skill.target == 1):
			skill_desc += "enemy"
		skill_desc += "\n"
		if (skill.health != Vector2.ZERO):
			skill_desc += "- attack power: " + String(skill.health.x) + "-" + String(skill.health.y) + "\n"
		if (skill.defense != Vector2.ZERO):
			skill_desc += "- defense: " + String(skill.defense.x) + "-" + String(skill.defense.y) + "\n"
		skill_desc += "- mana required: " + String(skill.mana_required)
		skill_node.init(
			"[Defense] " + skill.name, 
			skill_desc
		)
		skill_cont.add_child(skill_node)
	
	for i in range(0, PlayerManager.skills.attack.size()):
		var skill: Utils.Attack = PlayerManager.skills.attack[i]
		if (skill.unlocked != true):
			continue
		var skill_node: Node = skill_scene.instance()
		var skill_desc: String = ""
		skill_desc += "- target: "
		if (skill.target == 0):
			skill_desc += "self"
		if (skill.target == 1):
			skill_desc += "enemy"
		skill_desc += "\n"
		if (skill.health != Vector2.ZERO):
			skill_desc += "- attack power: " + String(skill.health.x) + "-" + String(skill.health.y) + "\n"
		if (skill.defense != Vector2.ZERO):
			skill_desc += "- defense: " + String(skill.defense.x) + "-" + String(skill.defense.y) + "\n"
		skill_desc += "- mana required: " + String(skill.mana_required)
		skill_node.init(
			"[Attack] " + skill.name, 
			skill_desc
		)
		skill_cont.add_child(skill_node)


func _on_HP_BTN_pressed():
	if (PlayerManager.sp.points > 0 && PlayerManager.hp.points < PlayerManager.hp.cap):
		PlayerManager.sp.points -= 1
		PlayerManager.hp.points += 1
		update_stats()

func _on_MR_BTN_pressed():
	if (PlayerManager.sp.points > 0 && PlayerManager.mr.points < PlayerManager.mr.cap):
		PlayerManager.sp.points -= 1
		PlayerManager.mr.points += 1
		update_stats()

func _on_AK_BTN_pressed():
	if (PlayerManager.sp.points > 0 && PlayerManager.ak.points < PlayerManager.ak.cap):
		PlayerManager.sp.points -= 1
		PlayerManager.ak.points += 1
		update_stats()
		if (PlayerManager.ak.points % 10 == 0):
			for i in range(0, PlayerManager.skills.attack.size()):
				var skill: Utils.Attack = PlayerManager.skills.attack[i]
				if (skill.unlocked != true):
					skill.unlock()
					break
			update_skills()

func _on_DEF_BTN_pressed():
	if (PlayerManager.sp.points > 0 && PlayerManager.def.points < PlayerManager.def.cap):
		PlayerManager.sp.points -= 1
		PlayerManager.def.points += 1
		update_stats()
		if (PlayerManager.def.points % 10 == 0):
			for i in range(0, PlayerManager.skills.defense.size()):
				var skill: Utils.Attack = PlayerManager.skills.defense[i]
				if (skill.unlocked != true):
					skill.unlock()
					break
			update_skills()

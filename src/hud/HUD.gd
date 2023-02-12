extends CanvasLayer

onready var hp_label = $HP_Label
onready var mb_label = $MB_Label

func _process(delta) -> void:
	if (Gamestate.state.has_book):
		hp_label.visible = true
		hp_label.text = String(PlayerManager.health) + "/" + String(PlayerManager.hp.points * PlayerManager.hp.multiply) + " HP"
		mb_label.visible = true
	else:
		hp_label.visible = false
		mb_label.visible = false

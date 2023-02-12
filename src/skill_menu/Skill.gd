extends VBoxContainer

onready var title_node: Node = $HBoxContainer/Title
onready var description_node: Node = $Description
onready var expand_btn: Node = $HBoxContainer/ExpandBTN

var title: String
var description: String

func _ready() -> void:
	title_node.text = title
	description_node.text = description

func init(
	title: String, 
	description: String
	) -> void:
		self.title = title
		self.description = description

func _on_ExpandBTN_toggled(button_pressed) -> void:
	if (button_pressed):
		expand_btn.text = "[-]"
		description_node.visible = true
	else:
		expand_btn.text = "[+]"
		description_node.visible = false

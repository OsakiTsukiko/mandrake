extends Node2D

onready var dmg_label = $Viewport/DMG
onready var def_label = $Viewport/DEF
onready var vp = $Viewport
onready var part = $CPUParticles2D
onready var tmr = $Timer

var type: int
var value: int

func init(type: int, value: int):
	self.type = type
	self.value = value

func _ready():
	if (type == 0):
		def_label.visible = true
		def_label.text = "+ " + String(value)
		vp.size = def_label.rect_size
	if (type == 1):
		dmg_label.visible = true
		dmg_label.text = "- " + String(value)
		vp.size = dmg_label.rect_size
	tmr.start(part.lifetime * part.speed_scale)

func _on_Timer_timeout():
	queue_free()

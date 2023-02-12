extends Node

const min_dB = -16
const max_dB = 6

var music_volume: float = 6
var sfx_volume: float = 6

var music_toggle: bool = true
var sfx_toggle: bool = true

var master_bus = AudioServer.get_bus_index("Master")
var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("Sfx")


onready var menu_click_sound = $MenuClick
onready var main_menu_bg = $MainMenuBG
onready var level1_bg = $Level1BG
onready var level2_bg = $Level2BG

func play_menu_click():
	if sfx_toggle:
		menu_click_sound.play()

func play_level_music(lvl_id: int):
	if lvl_id == 0:
		level1_bg.play()
	if lvl_id == 1:
		level2_bg.play()

func stop_level_music(lvl_id: int):
	if lvl_id == 0:
		level1_bg.stop()
	if lvl_id == 1:
		level2_bg.stop()

func change_music_volume(volume):
	music_volume = volume
	AudioServer.set_bus_volume_db(music_bus, music_volume)

func change_sfx_volume(volume):
	sfx_volume = volume
	AudioServer.set_bus_volume_db(sfx_bus, sfx_volume)

func toggle_music():
	music_toggle = !music_toggle
	AudioServer.set_bus_mute(music_bus, !music_toggle)

func toggle_sfx():
	sfx_toggle = !sfx_toggle
	AudioServer.set_bus_mute(sfx_bus, !sfx_toggle)

func _ready():
	main_menu_bg.play()

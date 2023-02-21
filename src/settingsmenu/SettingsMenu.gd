extends Control

onready var music_slider = $Panel/MarginContainer/TabContainer/Audio/MarginContainer/GridContainer/MusicSLIDER
onready var sfx_slider = $Panel/MarginContainer/TabContainer/Audio/MarginContainer/GridContainer/SoundSLIDER
onready var music_checkbox = $Panel/MarginContainer/TabContainer/Audio/MarginContainer/GridContainer/MusicCHX
onready var sfx_checkbox = $Panel/MarginContainer/TabContainer/Audio/MarginContainer/GridContainer/SoundCHX


func _ready():
	music_slider.value = SoundManager.music_volume
	sfx_slider.value = SoundManager.sfx_volume
	music_checkbox.pressed = SoundManager.music_toggle
	sfx_checkbox.pressed = SoundManager.sfx_toggle

func _on_BackButton_pressed():
	SoundManager.play_menu_click()
	Gamestate.load_main_menu()

func _on_tab_changed(tab):
	SoundManager.play_menu_click()


func _on_MusicCHX_pressed():
	SoundManager.toggle_music()
	SoundManager.play_menu_click()

func _on_SoundCHX_pressed():
	SoundManager.toggle_sfx()
	SoundManager.play_menu_click()


func _on_MusicSLIDER_drag_ended(value_changed):
	print()
	SoundManager.change_music_volume(music_slider.value)

func _on_SoundSLIDER_drag_ended(value_changed):
	print(value_changed)
	SoundManager.change_sfx_volume(sfx_slider.value)

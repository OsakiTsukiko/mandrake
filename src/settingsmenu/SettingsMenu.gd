extends Control

onready var music_slider = $Panel/MarginContainer/TabContainer/Audio/MarginContainer/GridContainer/MusicSLIDER
onready var sfx_slider = $Panel/MarginContainer/TabContainer/Audio/MarginContainer/GridContainer/SoundSLIDER

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
	SoundManager.change_music_volume(music_slider.value)

func _on_SoundSLIDER_drag_ended(value_changed):
	SoundManager.change_sfx_volume(sfx_slider.value)

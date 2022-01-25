extends Node

var height = ProjectSettings.get_setting("display/window/size/height")
var width = ProjectSettings.get_setting("display/window/size/width")

var allowMusic = true
var allowSound = true

var musicVolume = linear2db(0.5)
var effectVolume = linear2db(0.5)

func setMusicVolume(value: float):
	musicVolume = linear2db(value)
	print("New Music value: " + str(musicVolume))
	
func setEffectVolume(value: float):
	effectVolume = linear2db(value)
	print("New EffectMusic value: " + str(effectVolume))

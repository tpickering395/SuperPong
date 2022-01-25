extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



	

func _on_ReturnButton_pressed():
	get_tree().change_scene("res://scenes/Main_Menu.tscn")


func _on_MusicCheckBox_toggled(button_pressed):
		if button_pressed:
			Globals.allowMusic = true;
			print("Music enabled")
		else:
			Globals.allowMusic = false;
			print("Music disabled")


func _on_SoundCheckBox_toggled(button_pressed):
		if button_pressed:
			Globals.allowSound = true;
			print("Sound Enabled")
		else:
			Globals.allowSound = false;
			print("Sound Disabled")

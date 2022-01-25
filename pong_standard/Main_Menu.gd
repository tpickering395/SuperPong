extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var allowMusic = true;
export var allowSound = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/VBoxContainer/Classic_Start.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Classic_Start_pressed():
	get_tree().change_scene("res://scenes/game.tscn")


func _on_Modded_Start_pressed():
	get_tree().change_scene("res://scenes/mod_game.tscn")


func _on_Options_Button_pressed():
	get_tree().change_scene("res://scenes/Options_Menu.tscn")


func _on_Quit_Button_pressed():
	get_tree().quit()

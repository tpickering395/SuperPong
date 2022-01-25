extends KinematicBody2D

var speed = 175
var stop_up = false
var stop_down = false

func _physics_process(delta):
	if position.y -12 < 0:
		stop_up = true
	elif position.y + 12 > Globals.height:
		stop_down = true
	else:
		stop_up = false
		stop_down = false
		
	if Input.is_action_pressed("ui_up") && !stop_up:
		position.y -= speed * delta
	if Input.is_action_pressed("ui_down") && !stop_down:
		position.y += speed * delta

extends Area2D

var velocity = Vector2(0,0)
var cTimer = 0.5
var used = false


# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 1000
	position.y = 1000




func _on_Extra_Ball_body_entered(body):
	# ++
	if $"../ball".velocity.x > 0 and $"../ball".velocity.y > 0:
		$"../NewBall".position.x = position.x - 20
		$"../NewBall".position.y = position.y - 20
	
	# +-
	if $"../ball".velocity.x > 0 and $"../ball".velocity.y < 0:
		$"../NewBall".position.x = position.x - 20
		$"../NewBall".position.y = position.y + 20
	
	# -+
	if $"../ball".velocity.x < 0 and $"../ball".velocity.y > 0:
		$"../NewBall".position.x = position.x + 20
		$"../NewBall".position.y = position.y - 20
	
	# --
	if $"../ball".velocity.x < 0 and $"../ball".velocity.y < 0:
		$"../NewBall".position.x = position.x + 20
		$"../NewBall".position.y = position.y + 20
	
	# Give reversed fixed velocity
	if $"../ball".velocity.x > 0:
		$"../NewBall".velocity.x = -45
	else:
		$"../NewBall".velocity.x = 45
	
	if $"../ball".velocity.y > 0:
		$"../NewBall".velocity.y = -45
	else:
		$"../NewBall".velocity.y = 45
	
	# Releases the new ball
	$"../NewBall".stop = false
	
	# Hide Extra Ball
	position.x = 1000
	position.y = 1000

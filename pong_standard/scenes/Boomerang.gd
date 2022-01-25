extends Area2D
var quad = 5
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


func _on_Boomerang_body_entered(body):
	position.x = 1000
	
	if "NewBall" in str(body):
		$"../NewBall".velocity.x *= -1
		$"../NewBall".velocity.y *= -1
	else:
		$"../ball".velocity.x *= -1
		$"../ball".velocity.y *= -1

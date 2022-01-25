extends Area2D
var quad = 5
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	position.x = 1000
	position.y = 1000


func _on_Fire_Hoop_body_entered(body):
	# Hide hoop
	position.x = 1000
	
	# Check which body came in collision with the fire hoop
	if "NewBall" in str(body):
		$"../NewBall".velocity.x *= 1.2
		$"../NewBall".velocity.y *= 1.2
		$"../NewBall".ballColor = 3
	else:
		$"../ball".velocity.x *= 1.2
		$"../ball".velocity.y *= 1.2
		$"../ball".ballColor = 3


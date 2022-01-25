extends KinematicBody2D 

var speed = 45
var velocity = Vector2(0,0)
var direction = 1
var stop = false
var cTimer = 0.5
var rng = RandomNumberGenerator.new()
var ballColor = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if Globals.allowSound:
		$HitPlayer2D2.updateVolume(Globals.effectVolume)
	
	rng.randomize()
	ballColor = rng.randi_range(0,2)
	stop = true
	velocity.x = -speed
	velocity.y = -speed



func _physics_process(delta):
	# Change color of the ball based on ballColor (Yellow -> Green -> Red)
	if ballColor == 0:
		$Sprite.modulate = Color(1,1,0)
	if ballColor == 1:
		$Sprite.modulate = Color(0,1,0)
	if ballColor == 2:
		$Sprite.modulate = Color(1,0,1)
	if ballColor == 3:
		$Sprite.modulate = Color(1,0,0)
	
	# If game is currently stopped, hide the ball and prep position.
	if stop:
		$Sprite.hide()
		$CollisionShape2D.disabled = true
		position.x = Globals.width/2 + 4
		position.y = Globals.height/2 + 4
	
	# Game isn't stopped, let ball go
	else:
		$Sprite.show()
		$CollisionShape2D.disabled = false
		var collision = move_and_collide(velocity * delta)
		
		if collision and cTimer > 0.5:
			var reflect = collision.remainder.bounce(collision.normal)
			velocity = velocity.bounce(collision.normal)
			direction *= -1
			move_and_collide(reflect)
			velocity.x *= 1.05
			velocity.y *= 1.05
			ballColor = rng.randi_range(0,2)
			
			cTimer = 0
			if Globals.allowSound:
				$HitPlayer2D2.play()
			
		# flip velocity if ball stops?
		if velocity.x == 0:
			velocity.x = direction * abs(velocity.y)
			direction *= -1
			
		velocity = move_and_slide(velocity)
		
		# Hitting top of the screen
		if position.y - 2 < 0:
			velocity.x *= 1.02
			velocity.y *= -1.02
			
		# Hitting bottom of the screen
		if position.y + 2 > Globals.height:
			velocity.x *= 1.02
			velocity.y *= -1.02
		
		# increase timer for collisions to occur
		cTimer += delta



func _on_ui_score():
	stop = true

extends KinematicBody2D 

var speed = 45
var velocity = Vector2(0,0)
var direction = 1
var stop = false
var cTimer = 0.5
# Called when the node enters the scene tree for the first time.
func _ready():
	stop = true
	velocity.x = -speed
	velocity.y = -speed
	if Globals.allowSound:
		$HitPlayer2D.updateVolume(Globals.effectVolume)
	pass # Replace with function body.



func _physics_process(delta):
	
	if stop:
		$".".hide()
		$".".position.x = Globals.width/2 + 4
		$".".position.y = Globals.height/2 + 4
		pass
	else:
		var collision = move_and_collide(velocity * delta)
		
		if collision and cTimer > 0.5 :
			var reflect = collision.remainder.bounce(collision.normal)
			velocity = velocity.bounce(collision.normal)
			direction *= -1
			velocity.x *= 1.1
			velocity.y *= 1.1
			if Globals.allowSound:
				$HitPlayer2D.play()
			move_and_collide(reflect)
			cTimer = 0;

			
		if velocity.x == 0:
			velocity.x = direction * abs(velocity.y)
			direction *= -1
			
		velocity = move_and_slide(velocity)
		
		if position.y - 2 < 0:
			velocity.x *= 1.1
			velocity.y *= -1.1
			
		if position.y + 2 > Globals.height:
			velocity.x *= 1.1
			velocity.y *= -1.1
		cTimer += delta
	pass


func _on_ui_score():
	stop = true
	pass # Replace with function body.
